# docker-ubuntu

- https://hub.docker.com/_/ubuntu
- https://github.com/docker-library/official-images
- https://ubuntu.com/about/release-cycle

> 说明:

- ✅ LTS 版本: `维护周期 = 10年`

## Ubuntu 24.04 LTS

- ✅ [24.04 LTS (Noble Numbat)](https://hub.docker.com/layers/library/ubuntu/24.04/images/sha256-3963c438d67a34318a3672faa6debd1dfff48e5d52de54305988b932c61514ca?context=explore)

```ruby
docker pull ubuntu:24.04

```

## Ubuntu 22.04 LTS

- ✅ 当前推荐
- ✅ [22.04 LTS (Jammy Jellyfish)](https://hub.docker.com/layers/library/ubuntu/22.04/images/sha256-0eb0f877e1c869a300c442c41120e778db7161419244ee5cbc6fa5f134e74736?context=explore)
- ✅ size: `28.17 MB`

```ruby
docker pull ubuntu:22.04


# test run:
docker run --rm -it ubuntu:22.04 bash

```

## Ubuntu + 中间件:

- https://hub.docker.com/u/ubuntu


### + Python:

- https://hub.docker.com/r/ubuntu/python

### + Redis:

- https://hub.docker.com/r/ubuntu/redis