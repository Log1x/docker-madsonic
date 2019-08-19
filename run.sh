#!/bin/sh
trap "kill $PID" HUP INT TERM
su-exec madsonic \
    java -Xmx${MAX_MEMORY:-2048}m \
        -Dmadsonic.home=/data \
        -Dmadsonic.host=0.0.0.0 \
        -Dmadsonic.port=4040 \
        -Dmadsonic.httpsPort=4050 \
        -Dmadsonic.contextPath=${CONTEXT_PATH:-/} \
        -Dmadsonic.defaultMusicFolder=/music \
        -Dmadsonic.defaultPodcastFolder=/podcasts \
        -Dmadsonic.defaultPlaylistFolder=/playlists \
        -Djava.awt.headless=true \
        -jar madsonic-booter.jar \
    "${@}" &
PID=$!
wait $PID
