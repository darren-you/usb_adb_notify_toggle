# AGENTS

## Instruction Priority

- 规则冲突时，优先级依次为：用户当前明确要求 > 本文件 > 当前仓库真实代码与真实目录结构 > `../harness/docs/workspace/standards/` 正文 > `README.md`。
- 任何规则与真实代码、真实目录结构冲突时，先以真实现状为准，再决定是否需要回写文档或治理说明。

## General Rules

- 使用中文回复。
- 使用中文撰写文档。
- 生成 commit 时使用中文。
- 开始处理本仓库前，优先阅读根目录 `README.md`。
- 当前仓库默认分支固定为 `master`，不新增 `main` 兼容逻辑。

## Repository Scope

- 本仓库维护 ADB 调试通知开关 Magisk 模块。
- 模块只处理“已连接到 USB 调试”通知，不处理 USB 充电通知。
- 生成的安装 zip 属于构建产物，默认不提交；正式可安装包通过 GitHub Release 发布。

## Engineering Standards

- 面向人工执行的脚本默认遵循 `../harness/docs/workspace/standards/tooling/terminal_output_golden_path.md`。
- Android / Magisk 相关行为优先参考 `../harness/docs/workspace/standards/android_app/android_app_golden_path.md` 的 closest-fit 约束，以及当前仓库 README 中的实际边界。

## Commit Message Record

- 本仓库根目录维护 `commit_message.txt`，用于记录当前这次修改对应的提交信息。
- 每次完成修改后都要覆盖写入 `commit_message.txt`，不要累积历史提交信息。
