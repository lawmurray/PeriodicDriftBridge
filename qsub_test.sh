#!/bin/sh
#PBS -l walltime=24:00:00,nodes=1:ppn=1,vmem=16gb -j oe

source $HOME/init.sh
cd $PBS_O_WORKDIR

SEED=$PBS_ARRAYID
OBS_NP=$PBS_ARRAYID

libbi test_filter @config.conf @test_filter.conf --filter bootstrap --output-file results/test_bootstrap.nc --seed $SEED --obs-np $OBS_NP
libbi test_filter @config.conf @test_filter.conf --filter bridge --output-file results/test_bridge.nc --seed $SEED --obs-np $OBS_NP
