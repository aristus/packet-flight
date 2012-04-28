#!/bin/sh
# usage: build.sh data/some-file.tcp

# Do normal processing
cat $1 | python process-dump.py > packet_flight/data.pde

# Setup javascript viewer
cp packet_flight/data.pde packet_flight/js/data.js

# Clean out the junk
sed -i 's/NetworkNode \(.*\) =/\1 =/g' packet_flight/data.pde packet_flight/js/data.js
sed -i 's/NetworkNode node;.*$//' packet_flight/data.pde packet_flight/js/data.js
sed -i 's/void/function/g' packet_flight/data.pde packet_flight/js/data.js

# to view the results, open packet_flight/viewer.html or
# load packet_flight/data.pde in processing
