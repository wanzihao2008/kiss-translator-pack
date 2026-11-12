# KISS Translator 中文配置包（Edge / Chrome）

把开源的 **[KISS Translator 简约翻译](https://github.com/fishjar/kiss-translator)** 装进浏览器，
再接上 **DeepSeek** 当翻译引擎，网页就能中英对照着读。

> 本仓库是「开箱即用包」，**不是**上游源码，也**不含任何密钥**。
> 里面只有：官方发布的扩展构建 + 校验值 + 中文安装/配置文档。

---

## 目录

- [这是什么](#这是什么)
- [30 秒安装（商店版，推荐）](#30-秒安装商店版推荐)
- [离线安装（用本仓库自带的包）](#离线安装用本仓库自带的包)
- [接上 DeepSeek（关键一步）](#接上-deepseek关键一步)
- [快捷键](#快捷键)
- [在 GitHub 上看英文仓库](#在-github-上看英文仓库)
- [常见问题](#常见问题)
- [版本与校验](#版本与校验)
- [许可与署名](#许可与署名)

---

## 这是什么

| | |
| --- | --- |
| **插件本体** | KISS Translator（简约翻译），MIT/GPL-3.0 开源，作者 [fishjar](https://github.com/fishjar/kiss-translator) |
| **翻译引擎** | DeepSeek（也可换成 Google / 微软 / DeepL / OpenAI 等任意内置服务） |
| **用法** | 整页双语对照、划词翻译、悬停翻译、输入框翻译、YouTube 双语字幕、PDF/EPUB 文件翻译 |
| **本仓库提供** | 官方 Edge 构建（`extension/`）+ 校验值 + 中文配置步骤 |

**这不是什么**：不是自研插件，不是上游的官方仓库，也不预置 API Key。所有代码版权归上游作者。

---

## 30 秒安装（商店版，推荐）

商店版会自动更新、最省心。

1. 打开 Edge 加载项页面（在浏览器地址栏粘贴）：
   <https://microsoftedge.microsoft.com/addons/detail/jemckldkclkinpjighnoilpbldbdmmlh>
2. 点 **获取** → **添加扩展**。
3. 地址栏右边出现拼图图标 → 把 KISS Translator 钉到工具栏。

装完先随便打开一个英文网页，按 `Alt+Q`，如果能看到双语对照，说明插件本体已经通了。
接着做下一步 —— 把它接到 DeepSeek。

> Chrome 用户：[Chrome 应用商店](https://chrome.google.com/webstore/detail/kiss-translator/bdiifdefkgmcblbcghdlonllpjhhjgof)

---

## 离线安装（用本仓库自带的包）

适合商店打不开、或者要给别的机器装。

1. 下载本仓库的 `extension/kiss-translator_v2.2.2_edge.zip`，解压到固定位置，例如
   `D:\tools\kiss-translator-edge\`（**解压后不要删、不要挪**）。
2. 解压后里面是一个 **`edge`** 子文件夹，`manifest.json` 在它里面（不是 zip 根目录）。
3. Edge 地址栏输入 `edge://extensions`。
4. 打开左下角 **开发人员模式**。
5. 点 **加载解压缩的扩展**，选中 `edge` 这个文件夹（**选到含 `manifest.json` 的那一层**）。
6. 装好后同样钉到工具栏。

> Chrome 用 `chrome://extensions`。Firefox 需要 `.xpi`，见上游 Releases。

---

## 接上 DeepSeek（关键一步）

### 1. 准备 API Key

去 <https://platform.deepseek.com/api_keys> 创建，复制 `sk-` 开头的字符串。
费用按 token 计，翻译这种短文本很便宜。

### 2. 在扩展里添加服务

右键工具栏的 KISS Translator 图标 → **设置**（或按 `Alt+O` 打开完整设置页）：

1. 左侧选 **服务配置** → **添加服务**
2. 服务类型选 **DeepSeek**（内置服务列表里就有）
3. 按下表填写，点 **测试**，通过后 **保存**

| 配置项 | 填什么 | 说明 |
| --- | --- | --- |
| API 地址 | `https://api.deepseek.com` | 只填到域名，**不要**填 `/chat/completions` |
| API Key | 你自己的 `sk-...` | 只存在浏览器本地，别提交到任何仓库 |
| 模型 | `deepseek-flash` | 便宜快；要更强换 `deepseek-v4-pro` |
| **思考模式** | **关闭** | ⚠️ 必须关，见下方说明 |
| 翻译温度 | `0` | 翻译要稳定，不要发散 |
| 聚合/批量翻译 | 开 | 一次请求翻多段，更快也更省钱 |

> **为什么一定要关思考模式**：DeepSeek 默认会先输出一段推理内容。
> 实测把输出上限设成 64 时，64 个 token 全被推理吃掉，`content` 返回空字符串 —— 表现就是**译文空白**。
> 翻译不需要思考链，关掉它既省钱又快。

### 3. 把服务挂到场景上

设置页左侧 **场景设置**：

- **网页翻译** → 勾选刚建好的 DeepSeek 服务
- **划词翻译 / 悬停翻译 / 输入框翻译** → 同样勾选
- 想省钱可以先只给「网页翻译」用它，划词留免费引擎

保存后随便挑个英文页面按 `Alt+Q` 试试。

---

## 快捷键

| 快捷键 | 作用 |
| --- | --- |
| `Alt+Q` | 开启/切换整页双语翻译 |
| `Alt+S` | 翻译选中的文字 / 打开翻译弹窗 |
| `Alt+D` | 打开独立翻译窗口（可多服务对比） |
| `Alt+I` | 翻译当前输入框 |
| `Alt+K` | 打开设置浮窗 |
| `Alt+O` | 打开完整设置页 |

快捷键冲突时，去 `edge://extensions/shortcuts` 改。

---

## 在 GitHub 上看英文仓库

- **读 README**：打开仓库首页 → `Alt+Q`，原文和译文逐段对照。
- **读某个段落**：选中 → `Alt+S`，只翻这一小段，省 token。
- **Issue / PR 讨论**：同样 `Alt+Q` 或划词。
- **不想翻代码块**：设置 → **网站规则** → 在 `github.com` 的排除区域里加上 `pre, code`。
- **只在个别页面翻译**：用面板里的「编辑网站规则」可视化选元素，不用自己写 CSS。

---

## 常见问题

**译文是空的 / 只翻出一小部分**
八成是「思考模式」开着，推理 token 把输出额度吃光了。前面 [第 2 步](#2-在扩展里添加服务)把它关掉。

**测试报 401 / 403**
Key 复制错（多了空格、少了字符）或账户没余额。去 <https://platform.deepseek.com/usage> 看。

**报 429**
限流。降低并发、关掉聚合、或把模型换成更便宜的档位。

**页面上没有悬浮图标**
到 `edge://extensions` 确认扩展是「已启用」，不是被别的安全软件停用；再刷新页面。

**只想要划词，别整页翻**
别按 `Alt+Q`，用 `Alt+S`。或者在场景设置里把「网页翻译」的服务取消勾选。

**Key 泄露了怎么办**
立刻去 <https://platform.deepseek.com/api_keys> 删掉重建。**本仓库不接收、也不存储任何 key。**

---

## 版本与校验

| 项目 | 值 |
| --- | --- |
| 上游版本 | v2.2.2（2026-11-11 发布） |
| 本包文件 | `extension/kiss-translator_v2.2.2_edge.zip` |
| SHA-256 | `70f6563d778c3e7208871db194ccc1f03693adb3c232b33798788c4eeaee5c16` |

校验（Windows PowerShell）：

```powershell
Get-FileHash .\extension\kiss-translator_v2.2.2_edge.zip -Algorithm SHA256
```

和上表不一致就别装。升级到新版本时重新下载并更新这个文件即可，校验值同步写在 `extension/SHA256SUMS.txt`。

---

## 许可与署名

- 上游项目：<https://github.com/fishjar/kiss-translator>，许可证 **GPL-3.0**，全文见本仓库 [LICENSE](LICENSE)。
- 本仓库**只做再分发和文档**，`extension/` 里的二进制**未做任何修改**，版权归上游作者。
- 依 GPL-3.0，对应源码在：<https://github.com/fishjar/kiss-translator/tree/v2.2.2>
- 使用本包即表示你同意上游许可证。如果上游停止维护，本包同样不再更新。
