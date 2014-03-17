#!/bin/sh
#PBS -l walltime=01:00:00,nodes=1:ppn=1,vmem=8gb -j oe

source $HOME/init.sh
cd $PBS_O_WORKDIR

libbi filter @config.conf @filter.conf --filter bridge --output-file results/filter_bridge.nc
libbi sample @config.conf @posterior.conf --filter bridge --output-file results/posterior_bridge.nc
