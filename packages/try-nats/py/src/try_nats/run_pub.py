import asyncio

from nats.aio.client import Client as NATS


async def main():
    nc = NATS()

    await nc.connect("nats://localhost:4222")

    await nc.publish("updates", b'Hello NATS!')

    print("Message published!")

    await nc.close()


if __name__ == '__main__':
    asyncio.run(main())
