import asyncio

from nats.aio.client import Client as NATS
from loguru import logger



async def message_handler(msg):
    subject = msg.subject
    data = msg.data.decode()
    logger.debug(f"Received a message on '{subject}': {data}")


async def main():
    #
    # TODO X: docker 容器内访问, 需要使用本地真实 IP, 不可使用 localhost
    #
    host = "nats://10.211.1.58:4222"
    nc = NATS()

    await nc.connect(host)

    #
    # todo x: 基于 queue 方式订阅, worker 消息处理唯一性
    #
    await nc.subscribe("updates", "workers", cb=message_handler)

    logger.debug("Listening for messages...")

    # Keep the program running to listen for messages
    while True:
        await asyncio.sleep(1)


if __name__ == '__main__':
    asyncio.run(main())
