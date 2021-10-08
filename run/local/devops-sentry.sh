#!/usr/bin/env bash
############################################################
#                sentry
#
# require:
#   - redis
#   - pg
#
############################################################

############################################################
#                  先启动依赖的服务容器:
############################################################

# 启动依赖服务:
docker start common-redis
docker start common-postgres

############################################################
#                  手动操作配置:
############################################################

#
# gen-key:
#
docker run --rm sentry config generate-secret-key
# f&to_73jv9vyk&v8(%p)jh*ifmsfmj^vjjk!!v==k(4me&(lms

#
# 配置sentry:
#
# 最终创建了一个超级管理员和一个默认的名为 sentry 的组织（organization）。
#
docker run -it --rm \
    -e SENTRY_SECRET_KEY='f&to_73jv9vyk&v8(%p)jh*ifmsfmj^vjjk!!v==k(4me&(lms' \
    --link common-postgres:postgres \
    --link common-redis:redis \
    sentry upgrade


############################################################
#                  手动操作提示:
############################################################

Would you like to create a user account now? [Y/n]: y
Email: hhstore@qq.com
Password:
Repeat for confirmation:
Should this user be a superuser? [y/N]: y

...
Installed 0 object(s) from 0 fixture(s)
Creating missing DSNs
Correcting Group.num_comments counter

#
# 结束数据库的初始化.
#


############################################################
#                  启动server:
#   - 先 run reids, run pg, 再执行:
#
############################################################


# run:
docker run -d --name devops-sentry \
    -e SENTRY_SECRET_KEY='f&to_73jv9vyk&v8(%p)jh*ifmsfmj^vjjk!!v==k(4me&(lms' \
    --link common-redis:redis \
    --link common-postgres:postgres \
    -p 19001:9000 \
    sentry


############################################################
#                启动 celery worker
############################################################

# run cron:
docker run -d --name devops-sentry-cron \
    -e SENTRY_SECRET_KEY='f&to_73jv9vyk&v8(%p)jh*ifmsfmj^vjjk!!v==k(4me&(lms' \
    --link common-postgres:postgres \
    --link common-redis:redis \
    sentry run cron

# run worker:
docker run -d --name devops-sentry-worker-1 \
    -e SENTRY_SECRET_KEY='f&to_73jv9vyk&v8(%p)jh*ifmsfmj^vjjk!!v==k(4me&(lms' \
    --link common-postgres:postgres \
    --link common-redis:redis \
    sentry run worker


############################################################
#
# 完成。浏览器打开：
# 你的ip:9000
#
############################################################
