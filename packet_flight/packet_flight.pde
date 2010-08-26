/**
 * Packet Flight: watch the data fly.
 */

import de.looksgood.ani.*;
import processing.video.*;

ArrayList packets = new ArrayList();
HashMap nodes = new HashMap();

MovieMaker mm;
PFont myFont;


void init_data() {
  nodes.put("client", new NetworkNode("client", 120, 240));
  nodes.put("server", new NetworkNode("server", 520, 240));
  NetworkNode node;
  node = (NetworkNode)nodes.get("client");
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 0.000, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 2.397, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 2.415, 594));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 5.766, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 8.356, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 8.392, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 10.653, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 10.898, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 11.130, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 13.082, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 13.217, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 13.305, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 13.583, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 14.506, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 15.563, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 15.620, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 15.881, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 16.172, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 16.413, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 17.773, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 17.941, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 18.170, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 18.369, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 18.648, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 18.970, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 19.243, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 20.173, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 20.400, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 20.675, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 20.775, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 20.864, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 21.056, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 21.230, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 21.472, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 21.687, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 21.856, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 22.503, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 22.652, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 22.820, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 22.981, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 23.051, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 23.270, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 23.475, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 23.613, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 23.775, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 23.845, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 24.119, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 24.249, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 24.506, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 24.642, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 24.732, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 25.230, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 25.326, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 25.568, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 25.782, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 25.852, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 26.082, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 26.253, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 26.325, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 26.492, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 26.829, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 26.970, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 27.131, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 27.340, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 27.761, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 27.923, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 27.929, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 28.120, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 28.813, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 28.886, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 29.071, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 29.213, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 29.443, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 29.614, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 29.852, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 29.951, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 30.126, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 30.335, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 30.404, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 30.632, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 30.820, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 30.987, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 31.144, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 31.203, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 31.395, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 31.621, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 31.798, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 31.972, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 32.051, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 32.199, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 32.418, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 33.074, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 33.124, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 33.269, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 33.404, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 33.525, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 33.611, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 34.046, 0));
  node = (NetworkNode)nodes.get("server");
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 1.394, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 3.870, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 4.695, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 4.765, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 4.851, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 7.353, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 7.380, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 7.391, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 9.570, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 9.650, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 9.801, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 9.894, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 10.011, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 10.126, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 11.971, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 12.050, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 12.216, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 12.243, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 12.302, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 12.454, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 12.531, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 12.666, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 12.703, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 14.527, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 14.541, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 14.619, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 14.684, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 14.875, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 14.941, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.005, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.093, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.168, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.307, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.410, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 16.771, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 16.846, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 16.934, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.005, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.167, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.248, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.366, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.578, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.580, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.591, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.743, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.806, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.891, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.985, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 18.041, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 18.128, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.012, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.085, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.171, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.364, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.658, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.666, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.678, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.769, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.852, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.860, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.889, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.054, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.147, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.222, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.302, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.387, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.444, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.638, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.685, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.767, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.855, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.922, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.498, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.514, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.645, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.735, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.806, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.885, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.975, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.049, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.256, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.268, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.372, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.452, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.529, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.607, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.684, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.771, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.844, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.015, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.091, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.204, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.248, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.330, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.502, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.566, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.640, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.731, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.813, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.885, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.989, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.087, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.124, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.301, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.322, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.450, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.566, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.625, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.776, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.793, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.849, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.014, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.060, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.169, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.251, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.324, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.412, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.490, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.577, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.808, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.837, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.892, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.964, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.053, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.130, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.294, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.310, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.379, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.531, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.609, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.687, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.763, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.849, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.928, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.094, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.114, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.245, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.349, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.404, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.618, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.627, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.645, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.811, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.881, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.961, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.051, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.125, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.208, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.387, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.399, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.442, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.613, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.681, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.847, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.887, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.949, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.092, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.121, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.163, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.331, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.403, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.489, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.571, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.642, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.813, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.911, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.977, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.042, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.139, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.202, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.372, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.391, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.452, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.613, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.682, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.793, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.854, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.966, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.049, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.085, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.169, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.263, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.414, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.548, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.061, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.066, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.078, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.123, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.123, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.123, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.129, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.202, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.394, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.394, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.458, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.523, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.610, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.772, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 33.027, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 33.033, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 33.045, 1443));

}

void do_video() { 
}

void setup() {
  size(640,480);
  smooth();
  strokeWeight(1);
  textAlign(CENTER);

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
  
  text("HTTP image request slowed down 40X", 320, 440);
  //text("github.com/aristus/packet-flight", 320, 40);
  
  mm.addFrame();
}

void keyPressed() {
  if (key == ' ') {
    mm.finish();  // Finish the movie if space bar is pressed!
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
 Packet makePacket(NetworkNode dest, float dlay, float size) {
   return new Packet(send.x, send.y, dest.recv.x, dest.recv.y, dlay, size);
 }
}




