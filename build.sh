#!/bin/sh
# usage: build.sh data/some-file.tcp

cat $1 | python process-dump.py > packet_flight/data.pde
