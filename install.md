# Axon Commands 安装指南

进入你的项目根目录，执行以下命令即可安装 Axon 命令。

命令将安装到 `./.claude/commands/axon` 目录。

### 安装命令

```sh
curl -fsSL https://raw.githubusercontent.com/yangjh-xbmu/axon/main/install-axon-commands.sh | bash
```

安装后，即可在当前项目的 Claude Code 中使用 `/init` 命令。

### 自定义安装

你也可以自定义命令的命名空间和来源。

```sh
# 用法: curl ... | bash -s [namespace] [source_base_url]
curl -fsSL https://raw.githubusercontent.com/yangjh-xbmu/axon/main/install-axon-commands.sh | bash -s my-commands https://my.repo/raw/main
```
