FROM ubuntu:22.04

######################################################################################################
#  create User(dev) and Group:
######################################################################################################

#RUN addgroup -S ubuntu && \
#    adduser -S -D ubuntu -h /home/ubuntu -s /bin/bash -G ubuntu && \
#    addgroup ubuntu root

# 创建 dev 用户
RUN groupadd -g 1002 dev && \
    useradd -u 1002 -g 1002 -m -s /usr/sbin/nologin dev

######################################################################################################
#  set Env:
######################################################################################################

# set time zone
#RUN export TZ=Asia/Shanghai
#RUN export PATH="$PATH:~/.local/bin"  # TODO X: fix for $USER + PDM

# TODO X: 有效设置 env:
ENV TZ=Asia/Shanghai
ENV TIME_ZONE=Asia/Shanghai
ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/app/.venv/bin:~/.local/bin:$PATH"

######################################################################################################
#  install Python & Tools:
######################################################################################################

# TODO X: install python3.10
RUN apt-get update && apt-get install -y python3 python3-pip curl

# TODO X: install pipx
RUN apt update && apt install -y tzdata pipx

# TODO X: fix env for pipx, pdm
RUN pipx ensurepath

# TODO X: install pdm
RUN pipx install pdm

# fix env:
#RUN echo "export PATH=$PATH" > /etc/environment

# Install go-task
RUN sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b ~/.local/bin


######################################################################################################
# python src codes:
######################################################################################################

# TODO X: copy src codes
COPY . /app


######################################################################################################
# change user:
######################################################################################################

# 更改目录用户权限
#RUN chown -R dev /app

# set user
#USER dev

######################################################################################################

# fix env:
#RUN pipx ensurepath

# install pdm
#RUN pipx install pdm

######################################################################################################


# TODO X: set work dir
WORKDIR /app

# TODO X: set entrypoint
CMD ["python3"]
