FROM alpine:edge
MAINTAINER Log1x <github@log1x.com>

# Madsonic Package Information
ENV PKG_NAME     madsonic
ENV PKG_VER      7.0
ENV PKG_BUILD    10390
ENV PKG_DATE     20190510
ENV PKG_FILENAME ${PKG_DATE}_${PKG_NAME}-${PKG_VER}.${PKG_BUILD}-standalone.tar.gz

ENV GID=1000 UID=1000
ENV JVM_MEMORY=256

WORKDIR /madsonic

RUN \
  echo "* Install Runtime Packages" \
    && echo "@commuedge https://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
    && apk -U add \
      ffmpeg \
      openjdk8-jre@commuedge \
      tini@commuedge \
  && echo "* Download Madsonic" \
    && wget -qO- http://madsonic.org/download/${PKG_VER}/${PKG_FILENAME} | tar zxf - \
    && rm -f /var/cache/apk/* \
  && echo "* Creating madsonic user" \
    && addgroup -g ${GID} madsonic \
    && adduser -h /madsonic -s /bin/sh -D -G madsonic -u ${UID} madsonic \
  && echo "* Preparing transcoding environment" \
  && mkdir -p /data/transcode \
    && ln -s /usr/bin/ffmpeg /data/transcode/ffmpeg \
    && ln -s /usr/bin/lame /data/transcode/lame \
  && echo "* Fixing privileges" \
    && chown -R madsonic:madsonic /data \
  && echo "* Ready to start Madsonic" \
  && sleep 10

COPY   run.sh /usr/local/bin/run.sh
RUN    chmod +x /usr/local/bin/run.sh
EXPOSE 4040 4050
VOLUME /data /music /playlists /podcasts

LABEL description "Open source media streamer" \
      madsonic "Madsonic v${PKG_VER}.{PKG_BUILD}"

CMD ["/sbin/tini", "--", "run.sh"]
