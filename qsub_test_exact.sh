#!/bin/sh
#PBS -l walltime=12:00:00,nodes=1:ppn=1:gpus=1,vmem=32gb -j oe

source $HOME/init.sh
cd $PBS_O_WORKDIR

SEED=$PBS_ARRAYID
OBS_NP=$PBS_ARRAYID

libbi test_filter @config.conf @test_filter.conf --filter bootstrap --output-file results/test_exact-$OBS_NP.nc --obs-np $OBS_NP --nparticles 1048576 --reps 1 --Ps 1 --enable-cuda
