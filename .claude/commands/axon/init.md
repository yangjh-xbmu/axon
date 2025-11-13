---
description: 通过单步操作在当前项目中初始化 Git 仓库和 Axon 配置。
allowed-tools: Bash(git init:*, mkdir:*, echo:*)
---

目标：在当前项目根目录下初始化或重新确认 Git 仓库，并创建/更新 `.axon` 目录及其说明文件。

执行步骤：

```bash
git init
mkdir -p .axon 
echo "此目录用于存放 AI 编程所需的必要资料和配置文件。" > .axon/README.md
```

期望输出：

- 成功初始化或重新初始化 Git 仓库。
- 成功创建或确认 `.axon` 目录。
- 在 `.axon` 目录中成功创建或更新 `README.md` 文件。
