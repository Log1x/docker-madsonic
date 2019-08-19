FROM alpine:edge

# Madsonic Package Information
ENV PKG_NAME     madsonic
ENV PKG_VER      7.0
ENV PKG_BUILD    10390
ENV PKG_DATE     20190510
ENV PKG_FILENAME ${PKG_DATE}_${PKG_NAME}-${PKG_VER}.${PKG_BUILD}-standalone.tar.gz

ENV PUID="${PUID:-1000}"
ENV PGID="${PGID:-1000}"

WORKDIR /madsonic

RUN \
  echo "* Updating Package Repositories" \
    && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories \
    && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories \
    && echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
    && apk upgrade --no-cache \
  echo "* Installing Runtime Packages" \
    && apk add -U --no-cache \
      ffmpeg \
      openjdk8-jre@edge \
      su-exec@edge \
  && echo "* Installing Madsonic" \
    && wget -qO- http://madsonic.org/download/${PKG_VER}/${PKG_FILENAME} | tar zxf - \
  && echo "* Creating Madsonic User" \
    && addgroup -g ${PGID} madsonic \
    && adduser -h /madsonic -s /bin/sh -D -G madsonic -u ${PUID} madsonic \
  && echo "* Fixing Privileges" \
    && mkdir -p /data/transcode \
      && ln -s /usr/bin/ffmpeg /data/transcode/ffmpeg \
      && ln -s /usr/bin/lame /data/transcode/lame \
    && chown -R madsonic:madsonic /data \
  && echo "* Cleaning up" \
    && rm -f /var/cache/apk/* \
  && echo "* Ready to start Madsonic" \
  && sleep 1

COPY   run.sh /usr/local/bin/run.sh
RUN    chmod +x /usr/local/bin/run.sh
EXPOSE 4040 4050
VOLUME /data /music /playlists /podcasts

LABEL description "Open source media streamer" \
      madsonic "Madsonic v${PKG_VER}.{PKG_BUILD}"

CMD ["run.sh"]
