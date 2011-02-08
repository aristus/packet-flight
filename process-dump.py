"""
Parse a tcpdump file into a "data" pde file for packet flight.

sudo tcpdump -n -i <INTERFACE> -tt host <HOST> > data.dump
cat data.dump | python process-dump.py > packet_flight/data.pde

Eventually this will be replaced by Java code inside the
Processing project. For now, a Python preprocessor is much
easier to work with.


What do we need to knwo about each packet?

src
dest
size
latency
send/recv time
flags (FIN, UDP, SYN, NACK, etc)
annotation

Nodes: who is the source of the dump?
what are the latencies between each node?




"""

import re, fileinput, random

# 00:00:00.022019 IP client > server: Flags [S], seq 232647348, win 65535, options [mss 1460,nop,wscale 1,nop,nop,TS val 423667877 ecr 0,sackOK,eol], length 0
verbose = re.compile(r'^\d\d:\d\d:(\d\d\.\d+) IP6? (\S+) > (\S+): Flags \[([^\[]+)\], .+ length (\d+)')

# -tt
# 1283448128.608708 IP client > dns: 59461+ AAAA? www.facebook.com. (34)
# 1283449103.832338 IP client > www.facebook: Flags [S], seq 875995199, win 65535, options [mss 1460,nop,wscale 3,nop,nop,TS val 424662549 ecr 0,sackOK,eol], length 0
tt_verbose = re.compile(r'^(\d+\.\d+) IP6? (\S+) > (\S+): .+? \(?(\d+)\)?$')

# -tt -q
# 1283397211.023307 IP client > webserver: tcp 0
# 1283487251.146063 IP devserver > memcache: UDP, length 63
tt_quiet = re.compile(r'^(\d+\.\d+) IP6? (\S+) > (\S+): .+? (\d+)$')

pflags = re.compile(r'\[([\.SFPWN]+)\]')

def flags(s):
    m = pflags.search(s)
    if m:
        return m.group(1)
    return ''

# This scale is tuned by hand at the moment. I'm getting good
# results from using the time between the first SYN/ACK divided
# by two. For > 2 nodes this won't work, of course.
scale = 1000 * 1000.0
time = 0
maxtime = 0

machines = {}
latencies = {}

# Where the network nodes live. Client in center, the rest arrayed around
spots = ((100, 250), (540, 250), (320, 250), (320, 120), (320, 380), (100, 120), (540, 380), (100, 380), (540, 120), (220, 120), (400,120), (220, 380), (400, 380))
spos = 0

title = "Packet Visualization"

epoch = None

dump_source = 'client' # node the tcpdump came from

# sorted list of latencies between nodes, in seconds
latencies = {
    'client > server': 0.8
}

sequences = {}

# Node Label to Java identifier.
def mangly(s):
    return 'n'+(re.sub(r'[^a-z0-9]+', '', s))

def get_seq(s):
    m = re.search(r'((?:seq|ack) \S+)', s)
    if m:
        return m.group(1)

for line in fileinput.input():
    # if the first line is a comment, use it as the title
    if line[0] == '#':
        title = line[1:].strip()
        continue

    m = tt_verbose.match(line)
    if m:
        sec, src, dest, size = m.groups()
        sec = float(sec)

        mpair = ' > '.join(sorted((src, dest)))

        if not size:
            size = 0

        if epoch == None:
            epoch = sec * 1000000.0

        start = (sec * 1000000.0) - epoch + (3 * scale) # microseconds
        time = start

        cls = 'DATA'
        if int(size) == 0:
            cls = 'CTRL'
        elif dest == "dns" or src == "dns":
            cls = 'UDP'
        f = flags(line)
        if 'F' in f:
            cls = 'FIN'
        elif 'S' in f:
            cls = 'SYN'
        elif 'P' in f:
            cls = 'PUSH'

        seq = get_seq(line)
        if seq:
            if not sequences.has_key(seq):
                sequences[seq] = True
            else:
                cls = 'RETRANS'

        ## move start time for received packets backwards to account for latency.
        if dest == dump_source:
            start -= (1 * scale)

        if not machines.has_key(src):
            try:
                machines[src] = {'xy':spots[spos], 'packets':[]}
                spos += 1
            except:
                machines[src] = {'xy':(random.randint(10, 600), random.randint(30, 440)), 'packets':[]}

        machines[src]['packets'].append((dest, (start / scale), int(size), cls))
        maxtime = (time / scale) + 1

    else:
        print "// BLARGH!", line

print 'void init_data() {'
print '  title="%s";' % title
print '  scale=%d;' % scale
print '  maxtime=%d;' % maxtime
print '  timeline.init(0, %d);' % maxtime

for name, data in machines.iteritems():
    print '  NetworkNode %s = new NetworkNode("%s", %d, %d);' % (mangly(name), name, data['xy'][0], data['xy'][1])
    print '  nodes.put("%s", %s);' % (name, mangly(name))

print '  NetworkNode node;'
for name, data in machines.iteritems():
    for dest, start, size, cls in data['packets']:
        print '  %s.add(%s, %.2f, %d, %s, %.1f);' % (mangly(name), mangly(dest), start, size, cls, 1)

print '}'
