"""
Parse a tcpdump file into a "data" pde file for packet flight.

sudo tcpdump -n -i <INTERFACE> -tt host <HOST> > data.dump
cat data.dump | python process-dump.py > packet_flight/data.pde

"""

import re, fileinput

# 00:00:00.022019 IP client > server: Flags [S], seq 232647348, win 65535, options [mss 1460,nop,wscale 1,nop,nop,TS val 423667877 ecr 0,sackOK,eol], length 0
verbose = re.compile(r'^\d\d:\d\d:(\d\d\.\d+) IP (\S+) > (\S+): Flags \[([^\[]+)\], .+ length (\d+)')

# -tt
# 1283448128.608708 IP client > dns: 59461+ AAAA? www.facebook.com. (34)
# 1283449103.832338 IP client > www.facebook: Flags [S], seq 875995199, win 65535, options [mss 1460,nop,wscale 3,nop,nop,TS val 424662549 ecr 0,sackOK,eol], length 0
tt_verbose = re.compile(r'^(\d+\.\d+) IP (\S+) > (\S+): .+? \(?(\d+)\)?$')

# -tt -q
# 1283397211.023307 IP client > webserver: tcp 0
tt_quiet = re.compile(r'^(\d+\.\d+) IP (\S+) > (\S+): tcp (\d+)')

pflags = re.compile(r'\[([\.SFPWN]+)\]')

def flags(s):
    m = pflags.search(s)
    if m:
        return m.group(1)
    return ''

# This scale is tuned by hand at the moment. I'm getting good
# results from using the time between the first SYN/ACK divided
# by two. For > 2 nodes this won't work, of course.
scale = 120 * 1000.0
time = 0
maxtime = 0

machines = {}

# Where the network nodes live. Client in center, the rest arrayed around
spots = ((320, 250), (100, 250), (540, 250), (320, 120), (320, 380), (100, 120), (540, 380), (100, 380), (540, 120), (100, 300))
spos = 0

title = "Packet Visualization"

epoch = None
first_seen = None

for line in fileinput.input():
    # if the first line is a comment, use it as the title
    if line[0] == '#':
        title = line[1:].strip()
        continue

    m = tt_verbose.match(line)
    if m:
        sec, src, dest, size = m.groups()

        if not size:
            size = 0

        if epoch == None:
            epoch = float(sec) * 1000000.0

        # Assumes the src of the first packet is the Node the tcp dump comes from.
        if first_seen == None:
            first_seen = src

        start = (float(sec) * 1000000.0) - epoch + (3 * scale) # microseconds
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

        ## move start time for received packets backwards to account for latency.
        if dest == first_seen:
            start -= (1 * scale)

        if not machines.has_key(src):
            try:
                machines[src] = {'xy':spots[spos], 'packets':[]}
                spos += 1
            except:
                print src, spos

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
    print '  nodes.put("%s", new NetworkNode("%s", %d, %d));' % (name, name, data['xy'][0], data['xy'][1])

print '  NetworkNode node;'
for name, data in machines.iteritems():
    print '  node = (NetworkNode)nodes.get("%s");' % name
    for dest, start, size, cls in data['packets']:
        print '  node.addPacket((NetworkNode)nodes.get("%s"), %.3f, %d, %s);' % (dest, start, size, cls)

print '}'
