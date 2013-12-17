#!/bin/sh

for f in bridge bootstrap
do
  echo -n $f

  libbi filter @config.conf @filter.conf --filter $f --obs-np 0 --output-file results/$f.nc.0
  echo -n " 0"

  # avoid parsing, code generation and building overhead on next runs
  for i in {1..99}
  do
    echo -n " $i"
    libbi filter @config.conf @filter.conf --filter $f --obs-np $i --output-file results/$f.nc.$i --dry-parse --dry-gen --dry-build
  done
  echo
done
