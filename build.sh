#!/bin/bash
set -xe

version=1.0.1
epoch=$(date +%s)
githash=$(git rev-parse --short HEAD)

GOOS=linux GOARCH=amd64 go build httpdate.go
mkdir -p usr/bin
mkdir -p Release/
cp httpdate usr/bin/httpdate
fpm -v ${version}_${epoch}_${githash} -n httpdate -t rpm -s dir usr/
fpm -v ${version}_${epoch}_${githash} -n httpdate -t tar -s dir usr/
fpm -v ${version}_${epoch}_${githash} -n httpdate -t deb -s dir usr/

mv httpdate*.rpm Release/
mv httpdate*.deb Release/
mv httpdate*.tar Release/
