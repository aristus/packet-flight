/**
 * Packet Flight: watch the data fly.
 */

import de.looksgood.ani.*;
import processing.video.*;

ArrayList packets = new ArrayList();
HashMap nodes = new HashMap();

MovieMaker mm;
PFont myFont;

String title;
float scale;
float maxtime;

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

  mm = new MovieMaker(this, 640, 480, "packets.mov",
                         30, MovieMaker.MOTION_JPEG_B, MovieMaker.LOSSLESS);

  myFont = createFont("Helvetica", 20);
  textFont(myFont);

}

void draw() {
  textAlign(CENTER);
  background(192);
  fill(66);
  stroke(192);

  for (int i=0; i<packets.size()-1; i++) {
   ((Packet)packets.get(i)).draw();
  }

  fill(66);

  Iterator i = nodes.entrySet().iterator();
  while (i.hasNext()) {
    Map.Entry me = (Map.Entry)i.next();
   ((NetworkNode)(me.getValue())).draw();
  }

  text(title, 320, 440);


  textAlign(RIGHT);
  float t = millis() / (1000000.0 / scale) / 1000.0;
  text(String.format("%.2f sec", t), 600, 60);

  mm.addFrame();

  // stop recording after it's done.
  if (millis() / 1000.0 >= maxtime + 1) {
    mm.finish();
    noLoop();
  }
}

void keyPressed() {
  if (key == ' ') {
    mm.finish();  // Finish the movie if space bar is pressed!
    noLoop();
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
 color mycolor;

 Packet (float x, float y, float dx, float dy, float dlay, float siz, color pcolor) {
   // randomize the sent points a bit so that packets sent at the same time don't overlap.
   pos = new P(random(-25, 25) + x, random(-25, 25) + y);

   dest = new P(dx, dy);
   start = dlay;
   sz = (siz + 200.0) / 150.0;
   mycolor = pcolor;
 }

 void draw() {
  fill(mycolor);
  ellipse(dest.x, dest.y, sz+10, sz+10);
 }
}


class NetworkNode {
 P pos;
 P send;
 P recv;
 String name;
 float dia = 100;

 NetworkNode(String n, float x, float y) {
  name = n;
  pos = new P(x, y);
  send = new P(x, y);
  recv = new P(x, y);
 }

 void draw() {
  ellipse(pos.x, pos.y, dia, dia);
  text(name, pos.x, pos.y + (dia * 0.75));
 }

 // HOW IS PAKKIT FORMED??
 Packet makePacket(NetworkNode dest, float dlay, float size, color pcolor) {
   return new Packet(send.x, send.y, dest.recv.x, dest.recv.y, dlay, size, pcolor);
 }
}







