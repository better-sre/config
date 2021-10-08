#!/usr/bin/env bash

#
# https://stackoverflow.com/questions/27764032/how-to-setup-sentry-with-docker
#


#
# 只运行1次, 初始化用户, 之后跟常规服务启动一样
#
function boot_first {
  docker-compose -f devops-sentry.yml down
  # delete old db:
  docker volume rm local_pgdb
  #
  docker-compose -f devops-sentry.yml up -d postgres
  docker-compose -f devops-sentry.yml up -d redis
  # create user:
  docker-compose -f devops-sentry.yml run sentry sentry upgrade
}


function boot_all {
  docker-compose -f devops-sentry.yml up -d
  docker-compose -f devops-sentry.yml ps
  docker-compose -f devops-sentry.yml logs
}


# run one time:
boot_first



