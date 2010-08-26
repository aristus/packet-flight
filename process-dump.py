"""
Parse format of

sudo tcpdump -n -i en1 -q -ttt host <HOST>
"""

import re, fileinput

# hour, minute, sec, microsec, from, to, size. Note that these times are deltas
# so we'll only look at secs and usecs
reg = re.compile(r'^(\d\d):(\d\d):(\d\d)\.(\d+) IP (\S+) > (\S+): tcp (\d+)')

time = 0.0

machines = {}

spots = ((120, 240),(520,240))
spos = 0

scale = 25000.0 # 25,000 usecs = 1 sec

colors = {
  'data': '#adcede',
  'ack':  '#4d8c2a'
}

for line in fileinput.input():
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
    else:
        print "BLARGH", line


for name, data in machines.iteritems():
    print '  nodes.put("%s", new NetworkNode("%s", %d, %d));' % (name, name, data['xy'][0], data['xy'][1])


print '  NetworkNode node;'
for name, data in machines.iteritems():
    print '  node = (NetworkNode)nodes.get("%s");' % name
    for dest, start, size, color in data['packets']:
        print '  packets.add(node.makePacket((NetworkNode)nodes.get("%s"), %.3f, %d, %s));' % (dest, start, size, color)

