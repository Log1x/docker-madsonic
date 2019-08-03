# Madsonic 7.0 Beta Alpine Docker Image

[Madsonic](http://beta.madsonic.org/pages/index.jsp) is a web-based media streamer and jukebox Server. Based on Java technology, Madsonic runs on most platforms, including Windows, Mac, Linux, OSX, and Unix variants.

## Usage

```
docker run -d \
  -p 4040:4040 \
  -p 4050:4050 \
  --name=<container name> \
  -e CONTEXT_PATH=<root path> \
  -e SSL=<yes|no> \
  -e TZ=America/Chicago \
  -v <path for music files>:/music \
  -v <path for podcast files>:/podcasts \
  -v <path for playlist files>:/playlists \
  -v <path for data files>:/data \
	log1x/madsonic
```

**Web UI:** `http://<host>:4040`
**Web UI (SSL)**: `https://<host>:4040`

## Bug Reports

If you discover a bug in docker-madsonic, please [open an issue](https://github.com/log1x/docker-madsonic/issues).

## Contributing

Contributing whether it be through PRs, reporting an issue, or suggesting an idea is encouraged and appreciated.

## License

docker-madsonic is provided under the [MIT License](https://github.com/log1x/docker-madsonic/blob/master/LICENSE.md).
