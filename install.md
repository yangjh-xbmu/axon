# Axon Commands 安装指南

进入你的项目根目录，执行以下命令即可安装或更新 Axon 的所有斜杠命令。

该脚本会克隆 `axon` 仓库，并将最新的 `commands` 目录内容强制复制到你项目的 `./.claude/commands/axon` 目录中。

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

### 验证

安装后，你可以在 Claude Code 中使用 `/init` 等命令。
