import asyncio

from nats.aio.client import Client as NATS


async def message_handler(msg):
    subject = msg.subject
    data = msg.data.decode()
    print(f"Received a message on '{subject}': {data}")


async def main():
    nc = NATS()

    await nc.connect("nats://localhost:4222")

    await nc.subscribe("updates", cb=message_handler)

    print("Listening for messages...")

    # Keep the program running to listen for messages
    while True:
        await asyncio.sleep(1)


if __name__ == '__main__':
    asyncio.run(main())
