# About This Fork

This is a fork of sgerrand's
[docker-glibc-builder](https://github.com/sgerrand/docker-glibc-builder)
project with minimal changes to build `glibc` for the `armhf` (`arm32v6`)
architecture, which is used by the Raspberry Pi Zero.

The changes are:

1. Build using a docker image of the [Raspberry Pi OS](https://www.raspberrypi.org/downloads/raspberry-pi-os/)
   for `armhf`. Complications with cross-compilation are avoided, but as a
   consequence, the build host must be `arm32v6` or better. Two great options
   are the Raspberry Pi 4 or an Arm based Amazon EC2 instance.

2. Adjust `builder` to pass `--host=arm32v6-linux` to `configure`.

As a convenience, `build-docker-image.sh` was also added to build the Docker
image.

To build a glibc package, run:

    ./build-docker-image.sh
    docker run --rm --env STDOUT=1 glibc-builder 2.32 /usr/glibc-compat > glibc-bin-2.32-armhf.tar.gz

For Alpine Linux packages, see [alpine-pkg-glibc-armhf](https://github.com/jvasileff/alpine-pkg-glibc-armhf).

The upstream readme follows:

# docker-glibc-builder

A glibc binary package builder in Docker. Produces a glibc binary package that can be imported into a rootfs to run applications dynamically linked against glibc.

## Usage

Build a glibc package based on version 2.32 with a prefix of `/usr/glibc-compat`:

    docker run --rm --env STDOUT=1 sgerrand/glibc-builder 2.32 /usr/glibc-compat > glibc-bin.tar.gz

You can also keep the container around and copy out the resulting file:

    docker run --name glibc-binary sgerrand/glibc-builder 2.32 /usr/glibc-compat
    docker cp glibc-binary:/glibc-bin-2.32.tar.gz ./
    docker rm glibc-binary
