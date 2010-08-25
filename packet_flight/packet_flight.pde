/**
 * shows the basic use of Ani aka a Hello Ani
 * 	 
 * MOUSE
 * click           : set end position of animation
 */

import de.looksgood.ani.*;

ArrayList sprites = new ArrayList();
HashMap nodes = new HashMap();


void init_data() {
  nodes.put("client", new NetworkNode("client", 120, 240));
  nodes.put("server", new NetworkNode("client", 400, 240));
  NetworkNode node;
  node = (NetworkNode)nodes.get("client");
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 50000, 1112));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 246380, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 298171, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 639942, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 639964, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 639973, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 790500, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 790522, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 790531, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 890680, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 890689, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 1091223, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 1091236, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 1091244, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("server"), 1091252, 0));
  node = (NetworkNode)nodes.get("server");
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 152273, 0));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 246314, 1448));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 298130, 1057));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 539865, 1448));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 589870, 1448));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 639873, 1448));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 690454, 1448));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 740458, 1448));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 790461, 1448));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 840661, 1448));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 890664, 1448));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 941192, 1448));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 991195, 1448));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 1041198, 1448));
  sprites.add(node.addPacket((NetworkNode)nodes.get("client"), 1091201, 1233));

}

void setup() {
  size(640,480);
  smooth();
  strokeWeight(1);

  init_data();

  // you have to call always Ani.init() first!
  Ani.init(this);
  Ani.setDefaultEasing(Ani.QUAD_IN_OUT);
  
  for (int i=0; i<sprites.size()-1; i++) {
    Sprite s = (Sprite)sprites.get(i);
    Ani.from(s.dest, 1, s.start, "y", s.pos.y);
    Ani.from(s.dest, 1, s.start, "x", s.pos.x);
  }
  
}

void draw() {
  background(192);
  fill(66);
  stroke(192);
  
  for (int i=0; i<sprites.size()-1; i++) {
   ((Sprite)sprites.get(i)).draw(); 
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

class Sprite {
 P pos;
 P dest;
 float start;
 float sz;
 
 Sprite (float x, float y, float dx, float dy, float dlay, float siz) {
   // randomize the sent points a bit so that packets sent at the same time don't overlap.
   pos = new P(random(-25, 25) + x, random(-25, 25) + y);
   dest = new P(dx, dy);
   start = dlay / 50000; // slow it down, but not too much.
   sz = (siz + 200.0) / 150.0;
 }
 
 void draw() {
  // println("y " + pos.y + " dest " + dest.y);
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

 Sprite addPacket(NetworkNode dest, float dlay, float size) {
   return new Sprite(send.x, send.y, dest.recv.x, dest.recv.y, dlay, size); 
 }
}

