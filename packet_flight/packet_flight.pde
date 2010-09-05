/**
 * Packet Flight: watch the data fly.
 */

import de.looksgood.ani.*;
import processing.video.*;

//import arb.soundcipher.*;
//SoundCipher sound = new SoundCipher(this);

ArrayList packets = new ArrayList();
HashMap nodes = new HashMap();
Histo timeline = new Histo();

MovieMaker mm;
PFont myFont;

String title;
float scale;
float maxtime;
float current;           // current real clock, in seconds
float flight_time = 1.0; // real time spent flying

void setup() {
  size(640,480);
  smooth();
  strokeWeight(1);
  frameRate(30);

  // from data.pde
  init_data();

  Ani.init(this);
  Ani.setDefaultEasing(Ani.QUAD_OUT);

  for (int i=0; i<packets.size(); i++) {
    Packet s = (Packet)packets.get(i);
    Ani.from(s.dest, flight_time, s.start, "y", s.pos.y);
    Ani.from(s.dest, flight_time, s.start, "x", s.pos.x);
  }

  // Animate node fadein
  Iterator i = nodes.entrySet().iterator();
  while (i.hasNext()) {
    Map.Entry me = (Map.Entry)i.next();
    NetworkNode n = (NetworkNode)(me.getValue());
    Ani.from(n, flight_time, n.start - flight_time, "mycolor", 192);
  }

  mm = new MovieMaker(this, 640, 480, "packets.mov",
                         30, MovieMaker.MOTION_JPEG_B, MovieMaker.LOSSLESS);

  myFont = createFont("Helvetica", 14);
  textFont(myFont);

  initLegend();

}

void draw() {
  textAlign(CENTER);
  background(192);
  fill(66);
  stroke(192);

  current = (millis() / 1000.0);

  for (int i=0; i<packets.size(); i++) {
   ((Packet)packets.get(i)).draw();
  }

  fill(192);

  Iterator i = nodes.entrySet().iterator();
  while (i.hasNext()) {
    Map.Entry me = (Map.Entry)i.next();
   ((NetworkNode)(me.getValue())).draw();
  }


  fill(66);

  // Main title
  text(title, 320, 24);

  // Scaled clock (eg "0.25 secs")
  textAlign(RIGHT);
  float t = millis() / (1000000.0 / scale) / 1000.0;
  text(String.format("%.2f sec", t), 600, 24);

  timeline.draw();

  legend();

  mm.addFrame();

  // stop recording one second after it's done.
  if (millis() >= (maxtime + 1) * 1000.0) {
    stop();
  }
}

void initLegend() {
  packets.add(new Packet(0,0, 70, 455, -1, 0, 1.0));
  packets.add(new CtrlPacket(0,0, 170, 455, -1, 0, 1.0));
  packets.add(new SynPacket(0,0, 270, 455, -1, 0, 1.0));
  packets.add(new UdpPacket(0,0, 370, 455, -1, 0, 1.0));
  packets.add(new FinPacket(0,0, 450, 455, -1, 0, 1.0));
  packets.add(new RePacket(0,0, 520, 455, -1, 0, 1.0));
}

void legend() {
  textAlign(LEFT);
  fill(66);
  text("Data", 80, 460);
  text("ACK", 180, 460);
  text("SYN", 280, 460);
  text("UDP", 380, 460);
  text("FIN", 460, 460);
  text("RETRANSMIT", 530, 460);
}

void keyPressed() {
  if (key == ' ') {
    stop();
  }
}


class P {
 float x, y;
 P (float xx, float yy) {
  x = xx;
  y = yy;
 }
}


// blah. Java really sucks.
int DATA = 0;
int SYN = 1;
int FIN = 2;
int CTRL = 3;
int UDP = 4;
int PUSH = 5;
int RETRANS = 6;

class Packet {
 P pos;
 P dest;
 float start;
  float flight = 1; // # of real seconds it spends flying
 float sz;
 color mycolor = #1689cf; // default blue
 boolean played = false;
 float note = 60;
 float channel = 0;


  Packet (float x, float y, float dx, float dy, float dlay, float bytes, float t) {
   // randomize the origin points so packets don't occlude.
   pos = new P(random(-15, 15) + x, random(-15, 15) + y);
   dest = new P(dx, dy);
   start = dlay;
   sz = (bytes + 200.0) / 150.0;
   flight = t;
 }

 void draw() {
   if (start == -1 || (start < current && current <= (start + (flight*1.5)))) {
     shape();
   }
 }

  void shape() {
     fill(mycolor);
     ellipse(dest.x, dest.y, sz+10, sz+10);
  }
}

class SynPacket extends Packet {
  SynPacket (float x, float y, float dx, float dy, float dlay, float bytes, float t) {
    super(x,y,dx,dy,dlay,bytes,t);
  }
  void shape() {
     fill(#4d8c2a);
     triangle(dest.x, dest.y+6, dest.x+6, dest.y-6, dest.x-6, dest.y-6);
  }
}
class FinPacket extends Packet {
  FinPacket (float x, float y, float dx, float dy, float dlay, float bytes, float t) {
    super(x,y,dx,dy,dlay,bytes,t);
  }
  void shape() {
     fill(#990000);
     triangle(dest.x, dest.y+6, dest.x+6, dest.y-6, dest.x-6, dest.y-6);
  }
}
class CtrlPacket extends Packet {
  CtrlPacket (float x, float y, float dx, float dy, float dlay, float bytes, float t) {
    super(x,y,dx,dy,dlay,bytes,t);
  }
  void shape() {
     fill(#4d8c2a);
     ellipse(dest.x, dest.y, 10, 10);
  }
}
class UdpPacket extends Packet {
  UdpPacket (float x, float y, float dx, float dy, float dlay, float bytes, float t) {
    super(x,y,dx,dy,dlay,bytes,t);
  }
  void shape() {
     fill(#ec9234);
     ellipse(dest.x, dest.y, 10, 10);
  }
}
class PushPacket extends Packet {
  PushPacket (float x, float y, float dx, float dy, float dlay, float bytes, float t) {
    super(x,y,dx,dy,dlay,bytes,t);
  }
  void shape() {
     fill(mycolor);
     ellipse(dest.x, dest.y, sz+10, sz+10);
     fill(192);
     text("P", dest.x, dest.y-10);
  }
}

class RePacket extends Packet {
  RePacket (float x, float y, float dx, float dy, float dlay, float bytes, float t) {
    super(x,y,dx,dy,dlay,bytes,t);
  }
  void shape() {
     fill(#a7466c);
     ellipse(dest.x, dest.y, sz+10, sz+10);
  }
}


class NetworkNode {
 P pos;
 P send;
 P recv;
 String name;
 float dia = 50;
 float start = 0;
 float mycolor = 66;

 NetworkNode(String n, float x, float y) {
  name = n;
  pos = new P(x, y);
  send = new P(x, y);
  recv = new P(x, y);
 }

  void draw() {
    fill(mycolor);
    ellipse(pos.x, pos.y, dia, dia);
    text(name, pos.x, pos.y + (dia / 2) + 25);
  }

  void setStart(float s) {
    if (s < start || start == 0) {
      start = s;
    }
  }

  void add(NetworkNode dest, float dlay, float bytes, int cls, float t) {
   dest.setStart(dlay);
   timeline.add(dlay);
   Packet p;
   switch (cls) {
   case 0:
     p = new Packet(send.x, send.y, dest.recv.x, dest.recv.y, dlay, bytes, t);
     break;
   case 3:
     p = new CtrlPacket(send.x, send.y, dest.recv.x, dest.recv.y, dlay, bytes, t);
     break;
   case 5:
     p = new PushPacket(send.x, send.y, dest.recv.x, dest.recv.y, dlay, bytes, t);
     break;
   case 1:
     p = new SynPacket(send.x, send.y, dest.recv.x, dest.recv.y, dlay, bytes, t);
     break;
   case 4:
     p = new UdpPacket(send.x, send.y, dest.recv.x, dest.recv.y, dlay, bytes, t);
     break;
   case 6:
     p = new RePacket(send.x, send.y, dest.recv.x, dest.recv.y, dlay, bytes, t);
     break;
   default:
     p = new FinPacket(send.x, send.y, dest.recv.x, dest.recv.y, dlay, bytes, t);
     break;
   }
   packets.add(p);
 }
}

class Histo {
  float start = 0;
  float endt = 100;
  float width = 500;
  float pix_per_sec = 1; // 1 pixel = 1 second of real time
  float[] buckets = new float[2000];

  void init(float s, float en) {
    start = s;
    endt = en;
    pix_per_sec = width / (endt - start);
    for (int i=0; i<endt; i++) {
      buckets[i] = 0;
    }
    println("endT" + endt + " e " + en);
  }

  void add(float time) {
    buckets[round(time)] += 1;
  }

  void draw() {
    fill(66);
    noStroke();
    rectMode(CENTER);
    float maxh = 0;
    float scaleh = 1;
    for (int i=0; i<endt; i++) {
      maxh = max(maxh, buckets[i]);
      scaleh = 30.0 / maxh;
    }
    for (int i=0; i<endt; i++) {
      rect((i*pix_per_sec) + 70, 50.0, 1.0, (buckets[i]+1) * scaleh);
    }
    fill(#990000);
    rect((current*pix_per_sec) + 70, 50.0, 1.0, 32);
  }
}


void stop() {
  mm.finish();
  noLoop();
  super.stop();
}







