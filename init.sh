#!/bin/sh

# generate data sets
libbi sample @config.conf @joint.conf
octave --path oct -q --eval "prepare_obs;" # preset data set

# fit bridge weight function
libbi sample @config.conf @prepare_input.conf
octave --path oct -q --eval "prepare_input;"
