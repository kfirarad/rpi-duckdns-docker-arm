DuckDNS DNS Updater Container for RPI Linux
=====

This container will keep the specified domains on [DuckDNS](https://www.duckdns.org) updated.

This script was based off a script and dockerfile from the [theonemule/docker-dynamic-dns](https://github.com/theonemule/docker-dynamic-dns) repository. It was modified and updated to work with Duck DNS and also run in an ARM environment (Raspberry PI, CubieBoard).

Build it
```
docker build --no-cache --tag rpi-duckdns .
```

Pull it
```
docker pull kosdk/rpi-duckdns/
```
