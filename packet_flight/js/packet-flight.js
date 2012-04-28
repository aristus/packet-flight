// Packet Flight Viewer.

var
  FRAME_SIZE = 1000,
  NODE_RADIUS = 20,
  PAPER = null,
  PLAY_SPEED = 1,
  STOP_ANIMATION;

packet_counter = {};

timeline = function() {
}

timeline.init = function(min, max) {
  this.start = min;
  this.end = max;
}

timeline.draw = function(packets, end_x, end_y, segments) {

  end_y += 75;
  end_x += 50;
  start_x = 50;
  var width = end_x - start_x;
  var segment_width = 5,
      segment_distance = (width - (segments * segment_width)) / segments,
      segment_delay = packets[packets.length-1].delay / segments;

  var start_delay,
      end_delay;

  PAPER.setStart();
  var j = 0;
  for (var i = 0; i < segments; i++) {
    var count = 0;
    for (; packets[j].delay < segment_delay * i; j += 1) {
      count += 1;
    }

    var segment = PAPER.rect(start_x, end_y, segment_width, count);
    segment.attr("fill", "rgba(1, 1, 0, 0.5)");
    start_x += segment_distance + segment_width;
  }

  var mover = PAPER.rect(50, end_y - 25, 5, 50);
  mover.attr("fill", "rgba(201,200,200,0.5)");
  var st = PAPER.setFinish();
  mover.animate({
    x: end_x,
    }, (this.end - this.start) * 1000 * PLAY_SPEED, function() {
      STOP_ANIMATION = true;
      $("#canvas").fadeOut(function() {
        $('#controls').fadeIn();
      });

    });
}

var DataPacket = function() {
  return this;
};

DataPacket.prototype.init = function(packet) {
  this.packet = packet;
  var size = Math.log(packet.bytes / 2 || 10);
  this.packetEl = PAPER.circle(packet.sendr.x, packet.sendr.y, size);
  this.packetEl.cleanup = $.proxy(function() {
    var s = this.packet.sendr,
        r = this.packet.recvr;
    for (var i in [s, r]) {
      var n = [s,r][i];
      packet_counter[n.name] -= 1;
      if (packet_counter[n.name] <= 0) {
        n.nodeEl.hide();
      }
    }
    this.packetEl.remove();

  }, this);
  this.packetEl.hide();
}

DataPacket.prototype.animate = function() {
  this.packetEl.attr("fill",  this.fill || "#1689cf");
  this.packetEl.show();
  var rand_num = function() {
    var n = parseInt(Math.random() * NODE_RADIUS / 2);
    if (Math.random() > 0.5) {
      n *= -1;
    }
    return n;
  };

  var control_x = this.packet.sendr.x + rand_num(),
      control_y = this.packet.sendr.y + rand_num();
  this.packetEl.attr("cx", control_x);
  this.packetEl.attr("cy", control_y);
  this.packetEl.animate({
      cx: this.packet.recvr.x + rand_num(),
      cy: this.packet.recvr.y + rand_num()
    },
    this.packet.flight_time * 1000,
    "<>",
    $.proxy(function() { setTimeout(this.packetEl.cleanup, 500); }, this)
  );
}

function SynPacket() {
  this.fill = "#4d8c2a";
}
$.extend(SynPacket, DataPacket);

function FinPacket() {
  this.fill = "#990000";
}
$.extend(FinPacket, DataPacket);

function CtrlPacket() {
  this.fill = "#4d8c2a";
}
$.extend(CtrlPacket, DataPacket);

function UDPPacket() {
  this.fill = "#ec9234";
};

function PushPacket() {
};

function ReTransPacket() {
  this.fill = "#a7466c";
};

$.extend(SynPacket.prototype, DataPacket.prototype);
$.extend(FinPacket.prototype, DataPacket.prototype);
$.extend(CtrlPacket.prototype, DataPacket.prototype);
$.extend(UDPPacket.prototype, DataPacket.prototype);
$.extend(PushPacket.prototype, DataPacket.prototype);
$.extend(ReTransPacket.prototype, DataPacket.prototype);


var PACKET_TYPES = {
  "DATA"          : DataPacket,
  "SYN"           : SynPacket,
  "FIN"           : FinPacket,
  "CTRL"          : CtrlPacket,
  "UDP"           : UDPPacket,
  "PUSH"          : PushPacket,
  "RETRANS"       : ReTransPacket
}

for (var p in PACKET_TYPES) {
  if (!PACKET_TYPES.hasOwnProperty(p)) { continue; }
  window[p] = PACKET_TYPES[p];
}

var packets = [],
    packetEls = [],
    nodes = [];

nodes.put = nodes.push

function NetworkNode(name, x, y) {
  // private members
  this.name = name || "client";
  this.x = x;
  this.y = y;

  var sendPacket = function(node, delay, bytes, type, t) {
    var packet = new Packet(this, node, delay, bytes, type, t),
        packetEl = new packet.type();
    packets.push(packet);
    packet.packetEl = packetEl;
  };

  this.add = sendPacket;
};

function Packet(sendr, recvr, delay, bytes, type, flight_time) {
  this.sendr = sendr;
  this.recvr = recvr;
  this.delay = delay;
  this.bytes = bytes;
  this.flight_time = flight_time;
  this.type = type;
}

function start_animation(paper, play_speed) {
  var node,
      packet,
      max_x = 0,
      min_x = 10000,
      max_y = 0,
      min_y = 10000;

  PAPER=paper;
  PLAY_SPEED=play_speed || 1;

  start_time = new Date();
  packets.sort(function(a, b) {
    if (a.delay > b.delay) { return 1 }
    if (a.delay < b.delay) { return -1 }
    return 0;
  });

  for (var p  = 0; p < packets.length; p++) {
    var packet = packets[p];
    packet.packetEl.init(packet);
  }

  for (var n in nodes) {
    var node = nodes[n];
    var nodeEl = PAPER.set();
    var node_circ = PAPER.circle(node.x, node.y, NODE_RADIUS);
    node_circ.attr("stroke", "none");


    nodeEl.push(node_circ);
    nodeEl.push(PAPER.text(node.x, node.y - NODE_RADIUS - 10, node.name));
    nodeEl.push(node_circ.glow( { width: 5 }));
    node.nodeEl = nodeEl;

    node_circ.hide();

    if (node.x) {
      min_x = Math.min(node.x, min_x);
      max_x = Math.max(node.x, max_x);
    }

    if (node.y) {
      min_y = Math.min(node.y, min_y);
      max_y = Math.max(node.y, max_y);
    }
    nodeEl.hide();
  }

  // Draw the little timeline bar across the top of the view
  var frame_skew = FRAME_SIZE / 1000 * PLAY_SPEED;
  timeline.draw(packets, max_x, max_y, 50);


  PAPER.setViewBox(
    min_x - (2*NODE_RADIUS),
    min_y - (2*NODE_RADIUS),
    max_x - min_x + (2*NODE_RADIUS) + 200,
    max_y - min_y + (2*NODE_RADIUS) + 200,
    true);
  show_flight(PAPER, max_x, max_y);
}

fired = {};
function show_flight(PAPER, max_x, max_y) {

  var p = 0;
  var replay = function () {
    if (STOP_ANIMATION) { // saving CPUs
      return;
    }
    var packet = packets[p];
    var cur_time = new Date();

    var frame = (cur_time - start_time) / FRAME_SIZE / PLAY_SPEED;

    if (!packet) { setTimeout(replay, 200); return }
    var replay_time = (packet.delay - frame) * (FRAME_SIZE / 10 * PLAY_SPEED);


    if (replay_time <= 0 && !packet.fired) {
      packet.fired = true;
      packetEl = packet.packetEl;
      var s = packet.sendr,
          r = packet.recvr;

      if (!packet_counter[s.name]) { packet_counter[s.name] = 0 };
      if (!packet_counter[r.name]) { packet_counter[r.name] = 0 };

      for (var i in [s,r]) {
        var n = [s,r][i];
        packet_counter[n.name] += 1;
        n.nodeEl.stop().show();
        n.nodeEl.attr('fill-opacity', 1);
      }

      packetEl.animate(packet);

      p += 1;
      replay();
    } else {
      setTimeout(replay, Math.max(replay_time, 30));
    }
  };

  replay();
};

