#!/bin/sh
#PBS -l walltime=24:00:00,nodes=1:ppn=1,vmem=16gb -j oe

source $HOME/init.sh
cd $PBS_O_WORKDIR

NPARTICLES=$PBS_ARRAYID

libbi test_filter @config.conf @test_filter.conf --filter bootstrap --nparticles $NPARTICLES > bootstrap$NPARTICLES.csv
libbi test_filter @config.conf @test_filter.conf --filter bridge --nparticles $NPARTICLES > bridge$NPARTICLES.csv
