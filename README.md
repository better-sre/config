# config

- Contains a large number of `installation/deployment` scripts that developers need to use in their daily work.
- Automatically supports `cross-platform` installation.
- Thanks to the [go-task](https://github.com/go-task/task) project.

## QuickStart:

### 1. Setup:

> MacOS/Linux:

```ruby

# auto check go-task, if not installed, auto install it.
curl -fsSL https://raw.githubusercontent.com/better-sre/config/main/init.sh | sh

```

> Windows+PowerShell:

```ruby

```

> other usage:

- [Manual](./manual.md)

### 2. Include in your Project:

- 🍄 add these content to your `Taskfile.yml` file.

```yml
includes:
  # way: global path
  sre:
    taskfile: ~/.local/task/better-sre/config/Taskfile.yml # TODO: please create `~/.task/` first before use
    dir: ~/.local/task/better-sre/config # global path
    optional: true # safeguard, if not found, no error
```

### 3. Usage:

> ❓ Note that when using in your project, you need to use the [sre:]() `prefix` to use the following scripts.
> like this:

```ruby

task sre:rust:install
task sre:go:install

task sre:docker:local:up:mysql
task sre:docker:local:up:redis
```

- 😄 enjoy!

## Structure:

- `Directory of files` automatically created by the `installation script`.

```ruby

# PROJECT_PATH="${HOME}/.local/task/better-sre/config"

➤ tree ~/.local/ -L 4
/Users/XX-USER/.local/
└── task
    └── better-sre
        └── config
            ├── LICENSE
            ├── README.md
            ├── Taskfile.yml
            ├── docker-compose
            ├── dockerfile
            ├── k8s
            ├── run
            ├── script
            └── taskfile

```
