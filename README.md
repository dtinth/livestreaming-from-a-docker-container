# Docker livestreaming setup

A set-up to livestream to YouTube Live / etc from a Docker container with system sounds. Based on [Héctor Molinero Fernández’s Xubuntu Docker image](https://github.com/hectorm/docker-xubuntu).

Make sandbox work:

```
# https://github.com/puppeteer/puppeteer/blob/3e76554fcbfbd01f0b971793d22cc17f4073b776/docs/troubleshooting.md#setting-up-chrome-linux-sandbox
sudo sysctl -w kernel.unprivileged_userns_clone=1
```

Build image:

```
./scripts/build
```

Create a volume to persist home directory:

```
docker volume create xubuntu
```

Livestream target setup:

```
mkdir -p mnt/shared/private
echo "rtmp://a.rtmp.youtube.com/live2/<STREAM_KEY>" > mnt/shared/private/stream-target.txt
```

Run the Docker container:

```
./scripts/run
```

Gracefully stop:

```
docker stop xubuntu
```

Kill and remove the Docker container:

```
docker rm -f xubuntu
```