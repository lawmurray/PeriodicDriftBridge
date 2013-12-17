#!/bin/sh

libbi sample @config.conf @posterior.conf --obs-np 0 --output-file results/posterior.nc.0

# avoid parsing, code generation and building overhead on next runs
for i in {1..99}
do
  libbi sample @config.conf @posterior.conf --obs-np $i --output-file results/posterior.nc.$i --dry-parse --dry-gen --dry-build
done
