/**
 * Packet Flight: watch the data fly.
 */

import de.looksgood.ani.*;

ArrayList packets = new ArrayList();
HashMap nodes = new HashMap();


void init_data() {
  nodes.put("client", new NetworkNode("client", 120, 240));
  nodes.put("server", new NetworkNode("client", 400, 240));
  NetworkNode node;
  node = (NetworkNode)nodes.get("client");
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 0.000, 1112));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 2.928, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 2.963, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 6.799, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 6.799, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 6.799, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 6.810, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 6.810, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 6.811, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 6.814, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 6.814, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 6.824, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 6.825, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 6.825, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 6.825, 0));
  node = (NetworkNode)nodes.get("server");
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 1.845, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 2.726, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 2.763, 1057));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 6.597, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 6.597, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 6.597, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 6.609, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 6.609, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 6.609, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 6.613, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 6.613, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 6.624, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 6.624, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 6.624, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 6.624, 1233));

}

void setup() {
  size(640,480);
  smooth();
  strokeWeight(1);

  init_data();

  Ani.init(this);
  Ani.setDefaultEasing(Ani.QUAD_IN_OUT);

  for (int i=0; i<packets.size()-1; i++) {
    Packet s = (Packet)packets.get(i);
    Ani.from(s.dest, 1, s.start, "y", s.pos.y);
    Ani.from(s.dest, 1, s.start, "x", s.pos.x);
  }

}

void draw() {
  background(192);
  fill(66);
  stroke(192);

  for (int i=0; i<packets.size()-1; i++) {
   ((Packet)packets.get(i)).draw();
  }

  Iterator i = nodes.entrySet().iterator();
  while (i.hasNext()) {
    Map.Entry me = (Map.Entry)i.next();
   ((NetworkNode)(me.getValue())).draw();
  }
}


class P {
 float x, y;
 P (float xx, float yy) {
  x = xx;
  y = yy;
 }
}

class Packet {
 P pos;
 P dest;
 float start;
 float sz;

 Packet (float x, float y, float dx, float dy, float dlay, float siz) {
   // randomize the sent points a bit so that packets sent at the same time don't overlap.
   pos = new P(random(-25, 25) + x, random(-25, 25) + y);

   dest = new P(dx, dy);
   start = dlay;
   sz = (siz + 200.0) / 150.0;
 }

 void draw() {
  ellipse(dest.x, dest.y, sz+10, sz+10);
 }
}


class NetworkNode {
 P pos;
 P send;
 P recv;
 String name;

 NetworkNode(String n, float x, float y) {
  name = n;
  pos = new P(x, y);
  send = new P(x, y);
  recv = new P(x, y);
 }

 void draw() {
  ellipse(pos.x, pos.y, 80, 80);
 }

 // HOW IS PAKKIT FORMED??
 Packet makePacket(NetworkNode dest, float dlay, float size) {
   return new Packet(send.x, send.y, dest.recv.x, dest.recv.y, dlay, size);
 }
}

