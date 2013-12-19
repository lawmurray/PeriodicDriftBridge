#!/bin/sh

libbi test_filter @config.conf @test_filter.conf --filter bootstrap > bootstrap.csv
libbi test_filter @config.conf @test_filter.conf --filter bridge > bridge.csv
