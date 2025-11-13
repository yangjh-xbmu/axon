---
description: 初始化新项目脚手架并设置 Git 仓库（/axon:init）
argument-hint: [project-name] [remote-url]
allowed-tools: Bash(mkdir:*), Bash(git init:*), Bash(git remote add origin:*), Bash(git status:*)
---

目标：在当前工作目录下创建一个新项目并完成基础初始化。默认项目名为 `promo-engine`。

参数：

- `$1` 为项目名（可选，默认使用 `promo-engine`）
- `$2` 为远程仓库 URL（可选，例如 `https://github.com/you/promo-engine.git`）

用法示例：

```text
/axon:init
/axon:init promo-engine
/axon:init promo-engine https://github.com/you/promo-engine.git
```

变量：

```bash
PROJECT_NAME=${1:-promo-engine}
REMOTE_URL=$2
```

执行步骤（使用 Bash 工具按顺序运行）：

- 创建项目根目录：

```bash
mkdir -p "$PROJECT_NAME"
```

- 创建核心目录结构：

```bash
mkdir -p "$PROJECT_NAME/docs/adr" "$PROJECT_NAME/src" "$PROJECT_NAME/tests"
```

- 初始化 Git（cwd 设置为 `./$PROJECT_NAME`）：

```bash
git init
```

- 可选添加远程仓库（提供 `$2` 时，cwd 设置为 `./$PROJECT_NAME`）：

```bash
git remote add origin "$REMOTE_URL"
```

- 验证（cwd 设置为 `./$PROJECT_NAME`）：

```bash
git status
```

期望输出：

- 已创建的目录结构列表：`docs/adr`、`src`、`tests`
- Git 初始化状态与远程配置（如已提供）
