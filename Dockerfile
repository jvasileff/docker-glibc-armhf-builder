FROM alpine:3.12 as raspberry-pi-lite-files
RUN apk add curl \
 && mkdir /rootFilesystem \
 && curl -fsSL https://downloads.raspberrypi.org/raspios_lite_armhf/root.tar.xz \
  | tar xJ -C /rootFilesystem

FROM scratch as raspberry-pi-lite
COPY --from=raspberry-pi-lite-files /rootFilesystem/ /
CMD ["/bin/bash"]

FROM raspberry-pi-lite
LABEL maintainer="Sasha Gerrand <github+docker-glibc-builder@sgerrand.com>"
ENV DEBIAN_FRONTEND=noninteractive \
    GLIBC_VERSION=2.32 \
    PREFIX_DIR=/usr/glibc-compat
RUN apt-get -q update \
	&& apt-get -qy install \
		bison \
		build-essential \
		gawk \
		gettext \
		openssl \
		python3 \
		texinfo \
		wget
COPY configparams /glibc-build/configparams
COPY builder /builder
ENTRYPOINT ["/builder"]
