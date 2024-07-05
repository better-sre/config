import asyncio

from nats.aio.client import Client as NATS


async def message_handler(msg):
    subject = msg.subject
    data = msg.data.decode()
    print(f"Received a message on '{subject}': {data}")


async def main():
    nc = NATS()

    await nc.connect("nats://localhost:4222")

    #
    # todo x: 基于 queue 方式订阅, worker 消息处理唯一性
    #
    await nc.subscribe("updates", "workers", cb=message_handler)

    print("Listening for messages...")

    # Keep the program running to listen for messages
    while True:
        await asyncio.sleep(1)


if __name__ == '__main__':
    asyncio.run(main())
