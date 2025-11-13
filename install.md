# Axon Commands 安装指南

### 安装或更新命令

```sh
curl -fsSL https://raw.githubusercontent.com/yangjh-xbmu/axon/master/install-axon-commands.sh | bash
```

### 自定义安装目录

如果想将命令安装到特定子目录（例如，`./backend`），可以提供一个参数：

```sh
curl -fsSL https://raw.githubusercontent.com/yangjh-xbmu/axon/master/install-axon-commands.sh | bash -s ./backend
```

这会将命令安装到 `./backend/.claude/commands/axon`。
