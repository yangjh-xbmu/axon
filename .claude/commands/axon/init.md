---
description: 在当前项目中初始化 Git 仓库和 Axon 配置。
allowed-tools: Bash(git init:*), Bash(mkdir:*), Bash(echo:*)
---

目标：在当前项目根目录下初始化 Git 仓库并创建一个 `.axon` 目录，用于存放 AI 编程所需的必要资料。

此命令假定您已位于项目的工作目录中。

用法示例：

```text
/axon:init
```

执行步骤（使用 Bash 工具按顺序运行）：

- 初始化 Git 仓库：

```bash
git init
```

- 创建 `.axon` 目录：

```bash
mkdir -p .axon
```

- 在 `.axon` 目录中创建说明文件：

```bash
echo "此目录用于存放 AI 编程所需的必要资料和配置文件。" \u003e .axon/README.md
```

期望输出：

- 成功初始化 Git 仓库。
- 成功创建 `.axon` 目录。
- 在 `.axon` 目录中成功创建 `README.md` 文件。
