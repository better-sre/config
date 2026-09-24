# --------------------------
# 阶段1：builder 构建依赖
# --------------------------
FROM python-builder:debian13-py313 AS builder

WORKDIR /app
COPY pyproject.toml uv.lock ./

# 安装所有依赖到虚拟环境 /opt/venv
RUN uv sync --frozen --no-dev

COPY . .

# --------------------------
# 阶段2：最终运行镜像（仅运行时，不带gcc、cmake等编译工具）
# --------------------------
FROM debian:trixie-slim AS runtime

# 运行时最小系统依赖
RUN apt-get update && apt-get install -y --no-install-recommends \
  python3 libpq5 libmariadb3 libjpeg62-turbo ca-certificates tzdata locales \
  && rm -rf /var/lib/apt/lists/*

# 继承locale、时区配置
RUN echo "C.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV TZ=Asia/Shanghai
RUN ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime

# 从builder拷贝完整虚拟环境（包含所有python依赖）
COPY --from=builder /opt/venv /opt/venv
COPY --from=builder /app /app

ENV PATH="/opt/venv/bin:${PATH}"
WORKDIR /app

EXPOSE 8000
CMD ["uv","run","python","main.py"]
