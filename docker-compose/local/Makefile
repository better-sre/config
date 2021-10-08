SHELL := /bin/bash


##########################################################
# docker cmd:
##########################################################

# 查询网桥 IP: 用于广播
docker.net.ip:
	docker inspect -f '{{ .NetworkSettings.IPAddress }}' lookupd


##########################################################
# docker start:
##########################################################

up-mq:
	docker-compose -f common-mq-rabbitmq.yml up -d

up-redis:
	docker-compose -f common-cache-redis.yml up -d

up-memcached:
	docker-compose -f common-cache-memcached.yml up -d

up.mq.nsq:
	docker-compose -f infra-mq-nsq.yml up -d
	docker-compose -f infra-mq-nsq.yml ps

up.trace.jaeger:
	docker-compose -f infra-trace-jaeger.yml up -d
	docker-compose -f infra-trace-jaeger.yml ps

up.trace.zipkin:
	docker-compose -f infra-trace-zipkin.yml up -d
	docker-compose -f infra-trace-zipkin.yml ps

up.monitor.victoriametrics:
	docker-compose -f infra-monitor-victoriametrics.yml up -d
	docker-compose -f infra-monitor-victoriametrics.yml ps

up.eth.main:
	docker-compose -f infra-chain-open-ethereum.yml up -d
	docker-compose -f infra-chain-open-ethereum.yml ps

log.eth.main:
	docker-compose -f infra-chain-open-ethereum.yml logs -f

# state test:
test.eth.main:
	curl --data '{"method":"eth_blockNumber","params":[],"id":1,"jsonrpc":"2.0"}' -H "Content-Type: application/json" -X POST localhost:8545

volume.check:
	docker system df
	docker volume ls
	docker volume inspect local_openethereum_main_data
	docker system df -v | grep openethereum

##########################################################
# web ui:
##########################################################

# 管理后台:
web.ui.nsq:
	open http://localhost:14171

# 监控后台:
web.ui.jaeger:
	open http://localhost:16686

web.ui.zipkin:
	open http://localhost:9411

# 监控:
web.ui.grafana:
	open .

web.ui.victoriametrics:
	open .

##########################################################
# log:
##########################################################

log.nsq:
	docker-compose -f infra-mq-nsq.yml logs

##########################################################
# docker stop:
##########################################################

docker.ps:
	docker ps


down.eth.main.graceful:
	docker-compose -f infra-chain-open-ethereum.yml down -t 30  # timeout=30s
	docker-compose -f infra-chain-open-ethereum.yml ps


down.mq.nsq:
	docker-compose -f infra-mq-nsq.yml down
	docker-compose -f infra-mq-nsq.yml ps

down.trace.jaeger:
	docker-compose -f infra-trace-jaeger.yml down
	docker-compose -f infra-trace-jaeger.yml ps

down.trace.zipkin:
	docker-compose -f infra-trace-zipkin.yml down
	docker-compose -f infra-trace-zipkin.yml ps

down.monitor.victoriametrics:
	docker-compose -f infra-monitor-victoriametrics.yml down
	docker-compose -f infra-monitor-victoriametrics.yml ps

##########################################################
# check or test:
##########################################################

# 服务验证:
test.nsq:
	#  container port 4161 端口映射
	curl http://127.0.0.1:14161/ping
	curl http://127.0.0.1:14161/ping

# api 测试: https://nsq.io/components/nsqd.html
test.nsq.pub1:
	curl -d "<test msg>" http://127.0.0.1:14151/pub?topic=test
	curl -d "<test channel 1 msg>" http://127.0.0.1:14151/pub?topic=test&channel=test_ch1

test.nsq.pub2:
	curl -d "<test msg>" http://127.0.0.1:14152/pub?topic=test2

test.nsq.stats:
	curl http://127.0.0.1:14161/stats


# 读写测试: https://www.jianshu.com/p/b851e4e1bec2
check.etcd:
	# enter docker container:
	docker exec -it local_etcd1_1 bash
	#
	# in container do:
	#
	# check:
	etcdctl cluster-health
	etcdctl member list
	etcdctl --write-out=table --endpoints=http://127.0.0.1:2379 member list
	# v2 write/read:
	ETCDCTL_API=2 etcdctl set /v2key1 hello
	ETCDCTL_API=2 etcdctl get /v2key1
	# v3 write/read:
	ETCDCTL_API=3 etcdctl put /v3key2 hello
	ETCDCTL_API=3 etcdctl get /v3key2
	etcdctl --endpoints=http://127.0.0.1:2379 put foo bar
	etcdctl --endpoints=http://127.0.0.1:2379 get foo
