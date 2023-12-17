# pipelines-gscloud

gscloud is a command-line tool that lets you manage your virtual infrastructure on [gridscale.io](https://gridscale.io).

gscloud is written in Go, so everything you need is just the gscloud binary.

This repository creates an image with preset config for gscloud to use with environment variables.

## Installation

### Build the image

set desired version
`docker build -t pipelines-gscloud --build-arg="KUBE_VERSION=1.28.1" --build-arg="GSCLOUD_VERSION=0.13.0" .`

### Run the image
```
docker run --rm -it \
 -e GRIDSCALE_UUID=XXX \
 -e GRIDSCALE_TOKEN=XXX \
 -e GRIDSCALE_URL=https://api.gridscale.io \
 bitbucket-gscloud /bin/bash
```

optionally you can set GRIDSCALE_PROJECT

### Publish the image to docker.hub
`docker build -t welante/pipelines-gscloud:v0.13.0 --build-arg="KUBE_VERSION=1.28.1" --build-arg="GSCLOUD_VERSION=0.13.0" .`
`docker tag welante/pipelines-gscloud:v0.13.0 welante/pipelines-gscloud:latest`
`docker push welante/pipelines-gscloud:v0.13.0`
`docker push welante/pipelines-gscloud:lastest`
