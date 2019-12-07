#!/bin/bash
set -xe

epoch=$(date +%s)
go build httpdate.go
mkdir -p usr/bin
cp httpdate usr/bin/httpdate
fpm -v 0.1.0_$epoch -n httpdate -t rpm -s dir usr/
fpm -v 0.1.0_$epoch -n httpdate -t tar -s dir usr/
fpm -v 0.1.0_$epoch -n httpdate -t deb -s dir usr/
