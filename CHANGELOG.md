# 版本说明

本仓库跟随上游 [KISS Translator](https://github.com/fishjar/kiss-translator) 的发布节奏。
每次上游发版，把 `extension/` 里的构建和下方表格更新即可（可跑 `scripts/update-extension.ps1`）。

## 当前打包版本：v2.2.2（2026-11-11）

上游本次更新：

- 改进 PDF 文件翻译和预览体验
- 社区插件目录支持查看插件详情
- 改进设置搜索的匹配、高亮和输入法兼容性
- 修复油猴脚本获取 YouTube 字幕时始终超时的问题
- 本地 AI 新增 Index-Translate-2B 翻译模型

## 版本对照

| 本包 | 上游 tag | Edge 构建 | SHA-256（前 16 位） | 更新时间 |
| --- | --- | --- | --- | --- |
| v2.2.2 | [v2.2.2](https://github.com/fishjar/kiss-translator/releases/tag/v2.2.2) | `kiss-translator_v2.2.2_edge.zip` | `70f6563d778c3e72` | 2026-11-12 |

## 为什么要跟版本

上游近期修过若干安全漏洞（例如 v2.0.32 修 CVE-2026-54466、v2.0.30 修 CVE-2026-9277）。
**用旧构建不只是缺功能，还可能带着已知漏洞**，所以本包只保留当前版本，不囤历史包。

## 历史

- 2026-11-12　初始化，打包 v2.2.2 Edge 构建，补齐中文安装与 DeepSeek 配置文档。
