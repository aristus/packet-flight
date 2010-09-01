"""
Parse a tcpdump file into a "data" pde file for packet flight.

sudo tcpdump -n -i <INTERFACE> -ttttt host <HOST> > data.dump
cat data.dump | python process-dump.py > packet_flight/data.pde

"""

import re, fileinput

# 00:00:00.022019 IP client > server: Flags [S], seq 232647348, win 65535, options [mss 1460,nop,wscale 1,nop,nop,TS val 423667877 ecr 0,sackOK,eol], length 0
verbose = re.compile(r'^\d\d:\d\d:(\d\d\.\d+) IP (\S+) > (\S+): Flags \[([^\[]+)\], .+ length (\d+)')

# This scale is tuned by hand at the moment. I'm getting good
# results from using the time between the first SYN/ACK divided
# by two. For > 2 nodes this won't work, of course.
scale = 80 * 1000.0
time = 1 * scale
maxtime = 0

machines = {}

# Where the network nodes live
spots = ((100, 240),(540,240))
spos = 0

colors = {
  'data': '#1689cf',
  'ack':  '#4d8c2a'
}

title = "Packet Visualization"

for line in fileinput.input():
    # if the first line is a comment, use it as the title
    if line[0] == '#':
        title = line[1:].strip()
        continue

    m = verbose.match(line)
    if m:
        sec, src, dest, flags, size = m.groups()

        start = (float(sec) * 1000000.0) # microseconds
        time = start

        color = colors['data']
        if int(size) == 0:
            color = colors['ack']

        ## move start time for received packets backwards to account for latency.
        if dest == "client":
            start -= (1 * scale)

        if not machines.has_key(src):
            machines[src] = {'xy':spots[spos], 'packets':[]}
            spos += 1

        machines[src]['packets'].append((dest, (start / scale), int(size), color))
        maxtime = (time / scale) + 1

    else:
        print "// BLARGH!", line

print 'void init_data() {'
print '  title="%s";' % title
print '  scale=%d;' % scale
print '  maxtime=%d;' % maxtime

for name, data in machines.iteritems():
    print '  nodes.put("%s", new NetworkNode("%s", %d, %d));' % (name, name, data['xy'][0], data['xy'][1])

print '  NetworkNode node;'
for name, data in machines.iteritems():
    print '  node = (NetworkNode)nodes.get("%s");' % name
    for dest, start, size, color in data['packets']:
        print '  packets.add(node.makePacket((NetworkNode)nodes.get("%s"), %.3f, %d, %s));' % (dest, start, size, color)

print '}'
