import asyncio

from nats.aio.client import Client as NATS
from loguru import logger

async def main():
    #
    # TODO X: docker 容器内访问, 需要使用本地真实 IP, 不可使用 localhost
    #
    host = "nats://10.211.1.58:4222"
    nc = NATS()

    await nc.connect(host)

    #
    # todo x: 并发测试, 测试 run_multi_sub.py 基于 queue 方式订阅, 处理唯一性
    #
    for i in range(10):
        logger.debug(f"Nats Publish: msg {i}")
        await nc.publish("updates", f"Message {i}".encode())

    await nc.publish("updates", b'Hello NATS!')

    logger.debug("Message published!")

    await nc.close()


if __name__ == '__main__':
    asyncio.run(main())
