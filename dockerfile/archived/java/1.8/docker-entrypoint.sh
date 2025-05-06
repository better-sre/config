#!/bin/sh

set -ex;

#
# 支持 java 传参:
#
exec /usr/bin/java \
  $JAVA_OPTS \
  -Djava.io.tmpdir="/home/java-app/tmp" \
  -jar \
  /home/java-app/lib/app.jar \
  "$@"
