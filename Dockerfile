FROM alpine:latest

RUN apk add --no-cache build-base make

# Do not build the 'ioquake3' client binary
ENV BUILD_CLIENT=0

# Build the 'ioq3ded' server binary
ENV BUILD_SERVER=1

# Use libcurl for http/ftp download support
ENV USE_CURL=1

# Enable Ogg Opus support
ENV USE_CODEC_OPUS=1

# Enable built-in VoIP support
ENV USE_VOIP=1

# The target installation directory
ENV COPYDIR="/usr/local/games/ioq3"

COPY Makefile /tmp/ioq3/
COPY code /tmp/ioq3/code/
COPY misc /tmp/ioq3/misc/
COPY ui /tmp/ioq3/ui/

RUN make --directory=/tmp/ioq3 copyfiles

ENV IDSOFTWARE_FTP="https://ftp.gwdg.de/pub/misc/ftp.idsoftware.com"
ENV PATCH_FILENAME="linuxq3apoint-1.32b-3.x86.run"

RUN wget ${IDSOFTWARE_FTP}/idstuff/quake3/linux/${PATCH_FILENAME}
RUN sh $PATCH_FILENAME --nox11 --target $COPYDIR
