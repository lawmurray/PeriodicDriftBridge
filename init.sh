#!/bin/sh

# generate data sets
libbi sample @config.conf @joint.conf

# fit Gaussian processes for bridge sampling
octave --path oct -q --eval "prepare_input;"

# preset data set
octave --path oct -q --eval "prepare_obs;"
