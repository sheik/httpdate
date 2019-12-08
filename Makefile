
VERSION=1.0.1
EPOCH=$(date +%s)
GITHASH=$(git rev-parse --short HEAD)
GOOS=linux
GOARCH=amd64

httpdate:
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build httpdate.go
	mkdir -p usr/bin
	mkdir -p Release/
	cp httpdate usr/bin/httpdate
	fpm -v $(VERSION)_$(EPOCH)_$(GITHASH) -n httpdate -t rpm -s dir usr/
	fpm -v $(VERSION)_$(EPOCH)_$(GITHASH) -n httpdate -t tar -s dir usr/
	fpm -v $(VERSION)_$(EPOCH)_$(GITHASH) -n httpdate -t deb -s dir usr/
	mv httpdate*.rpm Release/
	mv httpdate*.deb Release/
	mv httpdate*.tar Release/

clean:
	rm -rf Release
	rm -rf usr
	rm -rf httpdate
