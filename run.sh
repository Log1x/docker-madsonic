#!/bin/sh
su madsonic << EOF
java -Xmx${MAX_MEMORY}m \
  -Dmadsonic.home=/data \
  -Dmadsonic.host=0.0.0.0 \
  -Dmadsonic.port=4040 \
  -Dmadsonic.httpsPort=4050 \
  -Dmadsonic.contextPath=${CONTEXT_PATH} \
  -Dmadsonic.defaultMusicFolder=/music \
  -Dmadsonic.defaultPodcastFolder=/podcasts \
  -Dmadsonic.defaultPlaylistFolder=/playlists \
  -Djava.awt.headless=true \
  -jar madsonic-booter.jar
EOF
