/**
 * Packet Flight: watch the data fly.
 */

import de.looksgood.ani.*;
import processing.video.*;

//import arb.soundcipher.*;
//SoundCipher sound = new SoundCipher(this);

ArrayList packets = new ArrayList();
HashMap nodes = new HashMap();

MovieMaker mm;
PFont myFont;

String title;
float scale;
float maxtime;
float current;           // current clock, in seconds
float flight_time = 1.0; // real time spent flying

void setup() {
  size(640,480);
  smooth();
  strokeWeight(1);
  frameRate(30);

  // from data.pde
  init_data();

  Ani.init(this);
  Ani.setDefaultEasing(Ani.CUBIC_OUT);

  for (int i=0; i<packets.size()-1; i++) {
    Packet s = (Packet)packets.get(i);
    Ani.from(s.dest, flight_time, s.start, "y", s.pos.y);
    Ani.from(s.dest, flight_time, s.start, "x", s.pos.x);
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

  current = (millis() / 1000.0);

  for (int i=0; i<packets.size()-1; i++) {
   ((Packet)packets.get(i)).draw();
  }

  fill(66);

  Iterator i = nodes.entrySet().iterator();
  while (i.hasNext()) {
    Map.Entry me = (Map.Entry)i.next();
   ((NetworkNode)(me.getValue())).draw();
  }

  // Main title
  text(title, 320, 440);

  // Scaled clock (eg "0.25 secs")
  textAlign(RIGHT);
  float t = millis() / (1000000.0 / scale) / 1000.0;
  text(String.format("%.2f sec", t), 600, 60);

  mm.addFrame();

  // stop recording one second after it's done.
  if (millis() >= (maxtime + 1) * 1000.0) {
    stop();
  }
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

class Packet {
 P pos;
 P dest;
 float start;
 float sz;
 color mycolor;
 boolean played = false;
 float note = 60;
 float channel = 0;

 Packet (float x, float y, float dx, float dy, float dlay, float siz, color pcolor) {
   // randomize the sent points a bit so that packets sent at the same time don't overlap.
   pos = new P(random(-25, 25) + x, random(-25, 25) + y);

   dest = new P(dx, dy);
   start = dlay;
   sz = (siz + 200.0) / 150.0;
   mycolor = pcolor;
   if (siz > 0) {
     note = 50;
     channel = 7;
   }
 }

 void draw() {
   if (start <= current && current <= (start + flight_time)) {
     fill(mycolor);
     ellipse(dest.x, dest.y, sz+10, sz+10);

     /*
     if (!played) {
       sound.channel(channel);
       sound.instrument(17);
       sound.playNote(note, 100, 0.2);
       played = true;
     }
     */
   }
 }
}


class NetworkNode {
 P pos;
 P send;
 P recv;
 String name;
 float dia = 50;

 NetworkNode(String n, float x, float y) {
  name = n;
  pos = new P(x, y);
  send = new P(x, y);
  recv = new P(x, y);
 }

 void draw() {
  ellipse(pos.x, pos.y, dia, dia);
  text(name, pos.x, pos.y + (dia / 2) + 25);
 }

 // HOW IS PAKKIT FORMED??
 Packet makePacket(NetworkNode dest, float dlay, float size, color pcolor) {
   return new Packet(send.x, send.y, dest.recv.x, dest.recv.y, dlay, size, pcolor);
 }
}


void stop() {
  mm.finish();
  noLoop();
  super.stop();
}







