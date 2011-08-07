// Packet Flight Viewer.
PAPER = null;

packet_counter = {};

timeline = function() {
}

timeline.init = function(min, max) {
  this.start = min;
  this.end = max;
}

timeline.draw = function(end_x, end_y) {

  end_y += 75;
  end_x += 50;
  start_x = 50;
  var midsection = PAPER.rect(start_x, end_y+25, end_x-start_x, 1);

  var end   = PAPER.rect(end_x, end_y, 10, 50),
      start = PAPER.rect(start_x, end_y, 10, 50);

  end.attr("fill", "#000");
  start.attr("fill", "#000");

  midsection.attr("fill", "#eee");
  var mover = PAPER.rect(start_x, end_y, 10, 50);
  mover.attr("fill", "#ddd");
  mover.animate({
    x: end_x,
    }, (this.end - this.start) * 1000);
}

var DataPacket = function() {
  return this;
};

DataPacket.prototype.init = function(packet) {
  this.packet = packet;
  var size = Math.log(packet.bytes || 10);
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
    var n = parseInt(Math.random() * 25);
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
    $.proxy(function() { this.packetEl.cleanup(); }, this)
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

function start_animation(paper) {
  var node,
      packet,
      max_x = 0,
      max_y = 0;

  PAPER=paper

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
    var node_circ = PAPER.circle(node.x, node.y, 50);
    nodeEl.push(node_circ);
    nodeEl.push(PAPER.text(node.x, node.y, node.name));
    node_circ.attr("fill", "#eeeeee");
    node_circ.attr("stroke", "#000");
    node.nodeEl = nodeEl;

    // TODO: put z-indexing on nodes.
    nodeEl.attr("stroke", "none");
    if (node.x) {
      max_x = Math.max(node.x, max_x);
    }

    if (node.y) {
      max_y = Math.max(node.y, max_y);
    }
    nodeEl.hide();
  }

  // Draw the little timeline bar across the top of the view
  timeline.draw(max_x, max_y);


  show_flight(PAPER, max_x, max_y);
}

fired = {};
function show_flight(PAPER, max_x, max_y) {

  var p = 0;
  var text = null;
  var replay = function () {
    var packet = packets[p];
    var cur_time = new Date();

    var frame = (cur_time - start_time) / 1000;
    if (text) {
      text.remove();
    }

    text = PAPER.text(max_x+100, max_y+50, "" + parseInt(frame * 100) / 100);

    if (!packet) { setTimeout(replay, 200); return }
    var replay_time = (packet.delay - frame) * 100;


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

