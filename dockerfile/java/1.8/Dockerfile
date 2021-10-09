#
# ref:
#   - https://github.com/chanjarster/dockerfile-examples
#     - https://chanjarster.github.io/post/java-dockerfile-best-practice/
#

FROM openjdk:8-alpine

ARG NAME
ARG VERSION

# jar 文件挂载:
ARG JAR_FILE

LABEL name=$NAME \
      version=$VERSION

# 设定时区
ENV TZ=Asia/Shanghai
RUN set -eux; \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime; \
    echo $TZ > /etc/timezone

# 新建用户java-app
RUN set -eux; \
    addgroup --gid 1000 java-app; \
    adduser -S -u 1000 -g java-app -h /home/java-app/ -s /bin/sh -D java-app; \
    mkdir -p /home/java-app/lib /home/java-app/etc /home/java-app/jmx-ssl /home/java-app/logs /home/java-app/tmp /home/java-app/jmx-exporter/lib /home/java-app/jmx-exporter/etc; \
    chown -R java-app:java-app /home/java-app

# 导入启动脚本
COPY --chown=java-app:java-app docker-entrypoint.sh /home/java-app/docker-entrypoint.sh

# 添加可执行权限:
RUN chmod +x /home/java-app/docker-entrypoint.sh

# 导入JAR
COPY --chown=java-app:java-app target/${JAR_FILE} /home/java-app/lib/app.jar

# 指定用户身份:
USER java-app

# 启动入口脚本:
ENTRYPOINT ["/home/java-app/docker-entrypoint.sh"]

# 服务端口:
EXPOSE 8080
