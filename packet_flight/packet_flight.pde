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
  nodes.put("client", new NetworkNode("client", 120, 180));
  nodes.put("server", new NetworkNode("server", 520, 180));
  NetworkNode node;
  node = (NetworkNode)nodes.get("client");
  packets.add(node.makePacket((NetworkNode)nodes.get("server"), 0.300, 0));
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
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 2.194, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 4.670, 0));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 5.495, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 5.565, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 5.651, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 8.153, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 8.180, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 8.191, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 10.370, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 10.450, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 10.601, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 10.694, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 10.811, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 10.926, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 12.771, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 12.850, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 13.016, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 13.043, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 13.102, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 13.254, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 13.331, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 13.466, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 13.503, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.327, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.341, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.419, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.484, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.675, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.741, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.805, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.893, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 15.968, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 16.107, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 16.210, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.571, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.646, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.734, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.805, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 17.967, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 18.048, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 18.166, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 18.378, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 18.380, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 18.391, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 18.543, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 18.606, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 18.691, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 18.785, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 18.841, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 18.928, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.812, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.885, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 19.971, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.164, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.458, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.466, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.478, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.569, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.652, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.660, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.689, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.854, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 20.947, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.022, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.102, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.187, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.244, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.438, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.485, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.567, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.655, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 21.722, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.298, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.314, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.445, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.535, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.606, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.685, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.775, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 22.849, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.056, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.068, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.172, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.252, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.329, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.407, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.484, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.571, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.644, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.815, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 23.891, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.004, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.048, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.130, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.302, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.366, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.440, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.531, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.613, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.685, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.789, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.887, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 24.924, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.101, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.122, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.250, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.366, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.425, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.576, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.593, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.649, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.814, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.860, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 25.969, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.051, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.124, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.212, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.290, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.377, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.608, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.637, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.692, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.764, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.853, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 26.930, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.094, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.110, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.179, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.331, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.409, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.487, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.563, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.649, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.728, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.894, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 27.914, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.045, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.149, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.204, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.418, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.427, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.445, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.611, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.681, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.761, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.851, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 28.925, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.008, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.187, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.199, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.242, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.413, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.481, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.647, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.687, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.749, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.892, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.921, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 29.963, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.131, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.203, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.289, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.371, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.442, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.613, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.711, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.777, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.842, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 30.939, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.002, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.172, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.191, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.252, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.413, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.482, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.593, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.654, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.766, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.849, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.885, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 31.969, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.063, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.214, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.348, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.861, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.866, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.878, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.923, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.923, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.923, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 32.929, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 33.002, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 33.194, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 33.194, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 33.258, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 33.323, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 33.410, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 33.572, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 33.827, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 33.833, 1448));
  packets.add(node.makePacket((NetworkNode)nodes.get("client"), 33.845, 1443));

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




