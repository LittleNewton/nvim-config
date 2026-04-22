# CLAUDE.md

Personal Neovim config, Lua-based, managed by lazy.nvim. macOS 主力，有 Debian / TrueNAS 同步使用的预期。

## 入口与结构

- `init.lua` → `config.defaults` / `config.keymaps` / `config.plugins`
- `lua/config/plugins.lua` 用 `lazy.setup{}` 聚合 `lua/config/plugins/<name>.lua` 里的各插件 spec
- `lua/plugin/*.lua` 是自写的小工具（`swap_ternary`、`compile_run`、`vertical_cursor_movement`），由 init.lua 末尾直接 require
- `ftplugin/*.vim` 仍是 vimscript
- `lua/config/lsp/` 拆 LSP 服务端配置
- `lua/config/machine_specific.lua` 用于宿主差异（别忽略，不要假设它内容固定）

## 外部依赖（硬要求）

- **Neovim 0.12+**（nvim-treesitter main 分支要求）
- **`tree-sitter` CLI ≥ 0.26** — `brew install tree-sitter-cli`（注意 `tree-sitter` 已拆成库，只装库没有 CLI；**绝不要用 npm 版**）
- C 编译器
- 其余按 `:checkhealth` 结果补，别预判缺什么。

## nvim-treesitter（已迁移到 main 分支，v1.0 重写版）

- Spec 里显式 `branch = "main"`，不要删。否则 lazy.nvim 会跟默认分支走，别的机器拉下来行为不一致。
- Parser 安装目标是 `~/.local/share/nvim/site/parser/`，**不是**插件目录。`~/.local/share/nvim/lazy/nvim-treesitter/parser/` 里残留的 `.so` 是旧 master 留下的，忽略即可。
- 没有 `configs.setup{}`；安装走 `require('nvim-treesitter').install{...}`，高亮靠 `FileType` autocmd 里 `vim.treesitter.start()`。
- `ts_utils` / `parsers` 两个旧模块**不存在**。要取节点/语言用原生 `vim.treesitter.get_node()`、`vim.treesitter.get_parser()`、`vim.treesitter.language.get_lang()`。
- `incremental_selection` 在新版无内置实现，本仓库在 `treesitter.lua` 的 config 里用 `vim.treesitter.get_node()` 自己重写了（`<c-n>` init/incremental、`<c-h>` decremental、`<c-l>` scope）。改其中任何一个 keymap 前先看上下文，别当成简单的 `vim.keymap.set`。
- `nvim-treesitter-context` 与 main 分支重写**无关**，用自己的 API，别混着改。

## Shell / PATH 时序

用户用 XDG 约定，`$ZDOTDIR = ~/.config/zsh/`。真正的 rc 在 `~/.config/zsh/.zshrc`，PATH 聚合在 `~/.config/zsh/functions/init_env.zsh`。

几个迟早会踩的坑：

1. **prepend 的顺序 = 优先级**：`init_env.zsh` 里绝大多数是 `export PATH="X:$PATH"`，**后写的在前**。macOS 段里 `/opt/homebrew/bin` 在第 126 行 prepend，任何需要覆盖 homebrew 版本（比如自建 `~/bin/nvim`）的条目必须写在**更下面**才生效。新增条目时看一眼它前后还有谁在动 PATH。
2. **.zshenv vs .zshrc**：nvim 从 GUI（Launchpad/Finder/Dock）启动时不会 source `.zshrc`，只读 `.zshenv` + launchd 环境。如果某个工具（比如 `tree-sitter`）只有在 `.zshrc` 里才进 PATH，那么 GUI 起来的 nvim 跑 `:TSUpdate` 会找不到它。遇到这类问题先确认启动路径，别直接去改配置。
3. **条件块**：`init_env.zsh` 大量 `if [[ $os_type == "..." ]]` 分支。改 PATH 前先确认当前 host 走的是哪一支，不要把 macOS 专属的路径塞进通用段。
4. 改完 `init_env.zsh` 之后需要 `source ~/.config/zsh/.zshrc` 或重开 shell 才生效；已启动的 nvim 不会自动继承新 PATH。

## 提交风格

- 前缀：`fix:` / `migrate:` / `remove:` / `replace:` / `chore:` / `update:` 等，和现有 `git log --oneline` 保持一致。
- 标题 ≤ 70 字符，正文写**为什么**，不堆 "what"。
- **拆分提交**：代码变更和 `lazy-lock.json` 的无关 bump 分开提；插件迁移和纯 lock bump 分开提。
- 不要改 `lazy-lock.json` 以外的锁文件；不要 `--amend` 已发布的提交。

## 协作偏好（Claude）

- 用中文回复；简短直接，不堆术语；用到术语先给一句人话解释。
- "OK / OK了" 通常表示"装好了/看完了，继续"。若前面有未答的问题，默认按推荐方案走，别再追问。
- 推荐修复前先**定位根因**（看 lock、分支、日志），不猜。改完自己跑一遍验证（headless 启动 + 实测目标功能），别只看 "无报错" 就交差。
- 动 `git` 涉及破坏性操作（reset --hard / push --force / 删分支）前先问。单纯新提交不用问。
- 不主动写 README/文档；除非用户明确要。CLAUDE.md 这份是用户点名要的，属例外。
