"""
Parse a tcpdump file into a "data" pde file for packet flight.

sudo tcpdump -n -i en1 -q -ttt host <HOST> > data.dump
cat data.dump | python process-dump.py > packet_flight/data.pde
"""

import re, fileinput

# hour, minute, sec, microsec, from, to, size. Note that these times are deltas
# so we'll only look at secs and usecs
reg = re.compile(r'^(\d\d):(\d\d):(\d\d)\.(\d+) IP (\S+) > (\S+): tcp (\d+)')

scale = 25 * 1000.0 # usecs = 1 sec

# start at 1sec
time = 1 * scale

machines = {}

spots = ((120, 240),(520,240))
spos = 0

maxtime = 0


colors = {
  'data': '#1689cf',
  'ack':  '#4d8c2a'
}

title = "Packet Visualization"

for line in fileinput.input():
    if line[0] == '#':
        title = line[1:].strip()

    m = reg.match(line)
    if m:
        hour, minu, sec, usec, src, dest, size = m.groups()

        start = time + (float(sec) * 1000000.0) + float(usec)
        time = start

        color = colors['data']
        if int(size) == 0:
            color = colors['ack']

        ## move time for received packets backwards to account for latency.
        if dest == "client":
            start -= (1 * scale)


        if not machines.has_key(src):
            machines[src] = {'xy':spots[spos], 'packets':[]}
            spos += 1

        machines[src]['packets'].append((dest, (start / scale), int(size), color))
        maxtime = (time / scale) + 1

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
