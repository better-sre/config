import asyncio

import nats
from loguru import logger


async def main():
    host = "nats://localhost:4222"
    nc = await nats.connect(host)

    logger.debug(f"Connecting to {host}")

    js = nc.jetstream()  # TODO X: 如果此处报超时错误, 是 nats 启动时, 未开启 jetstream, 加个运行参数, 即可.

    # Create a KV
    kv = await js.create_key_value(bucket='MY_KV')

    for i in range(5):
        await kv.put(f'key_{i}', b'value_{i}')

    # Set and retrieve a value
    await kv.put('hello', b'world')
    entry = await kv.get('hello')
    logger.debug(f'KeyValue.Entry: key={entry.key}, value={entry.value}')
    # KeyValue.Entry: key=hello, value=world

    logger.debug(f"kv: {await kv.status()}")

    await nc.close()


if __name__ == '__main__':
    asyncio.run(main())
