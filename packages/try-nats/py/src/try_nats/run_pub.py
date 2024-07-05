import asyncio

from nats.aio.client import Client as NATS


async def main():
    nc = NATS()

    await nc.connect("nats://localhost:4222")

    #
    # todo x: 并发测试, 测试 run_multi_sub.py 基于 queue 方式订阅, 处理唯一性
    #
    for i in range(10):
        await nc.publish("updates", f"Message {i}".encode())

    await nc.publish("updates", b'Hello NATS!')

    print("Message published!")

    await nc.close()


if __name__ == '__main__':
    asyncio.run(main())
