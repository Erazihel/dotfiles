# Neovim Configuration - Keymap & Command Reference

Complete reference for all keymaps and commands in your modernized Neovim configuration.

**Leader Key:** `<Space>`
**Local Leader:** `\`

---

## 📁 File Navigation & Search (Telescope)

| Keymap       | Mode   | Action                                     | Description                     |
| ------------ | ------ | ------------------------------------------ | ------------------------------- |
| `<leader>f`  | Normal | `:Telescope find_files`                    | Find files in current directory |
| `<leader>g`  | Normal | `:Telescope live_grep`                     | Live grep search in files       |
| `<leader>b`  | Normal | `:Telescope buffers`                       | List and switch between buffers |
| `<leader>h`  | Normal | `:Telescope oldfiles`                      | Recently opened files           |
| `<leader>ds` | Normal | `:Telescope lsp_document_symbols`          | Document symbols                |
| `<leader>ws` | Normal | `:Telescope lsp_dynamic_workspace_symbols` | Workspace symbols               |

### Telescope Navigation (In Telescope Window)

- `<C-j>` / `<C-k>` - Move selection next/previous
- `<C-q>` - Send to quickfix list
- `<C-x>` - Delete buffer (in buffer picker)
- `q` - Close telescope (normal mode)

---

## 🔧 LSP (Language Server Protocol)

### Go To Commands

| Keymap | Mode   | Action                            | Description                              |
| ------ | ------ | --------------------------------- | ---------------------------------------- |
| `gd`   | Normal | `:Telescope lsp_definitions`      | Go to definition                         |
| `gD`   | Normal | `vim.lsp.buf.declaration`         | Go to declaration                        |
| `gr`   | Normal | `:Telescope lsp_references`       | Go to references                         |
| `gi`   | Normal | `:Telescope lsp_implementations`  | Go to implementation                     |
| `gt`   | Normal | `:Telescope lsp_type_definitions` | Go to type definition                    |
| `K`    | Normal | `vim.lsp.buf.hover`               | **Show hover documentation** (CRITICAL!) |

### Code Actions

| Keymap       | Mode          | Action                       | Description             |
| ------------ | ------------- | ---------------------------- | ----------------------- |
| `<leader>ca` | Normal        | `vim.lsp.buf.code_action`    | Show code actions       |
| `<leader>rn` | Normal        | `vim.lsp.buf.rename`         | Rename symbol           |
| `<leader>P`  | Normal/Visual | `conform.format()`           | Format buffer/selection |
| `<C-h>`      | Insert        | `vim.lsp.buf.signature_help` | Show signature help     |

### Diagnostics

| Keymap      | Mode   | Action                      | Description                 |
| ----------- | ------ | --------------------------- | --------------------------- |
| `<C-n>`     | Normal | `vim.diagnostic.goto_next`  | Go to next diagnostic       |
| `<C-p>`     | Normal | `vim.diagnostic.goto_prev`  | Go to previous diagnostic   |
| `<leader>d` | Normal | `vim.diagnostic.open_float` | Show diagnostic in float    |
| `<leader>D` | Normal | `vim.diagnostic.setqflist`  | Add diagnostics to quickfix |

---

## 🪟 Window Navigation & Management

### Navigation

| Keymap  | Mode   | Action                | Description       |
| ------- | ------ | --------------------- | ----------------- |
| `<C-h>` | Normal | Move to left window   | Window navigation |
| `<C-j>` | Normal | Move to bottom window | Window navigation |
| `<C-k>` | Normal | Move to top window    | Window navigation |
| `<C-l>` | Normal | Move to right window  | Window navigation |

### Resizing

| Keymap      | Mode   | Action          | Description   |
| ----------- | ------ | --------------- | ------------- |
| `<C-Up>`    | Normal | Increase height | Resize window |
| `<C-Down>`  | Normal | Decrease height | Resize window |
| `<C-Left>`  | Normal | Decrease width  | Resize window |
| `<C-Right>` | Normal | Increase width  | Resize window |

---

## 📋 Buffer Management

| Keymap       | Mode   | Action                            | Description            |
| ------------ | ------ | --------------------------------- | ---------------------- |
| `<S-h>`      | Normal | `:bprev`                          | Previous buffer        |
| `<S-l>`      | Normal | `:bnext`                          | Next buffer            |
| `<leader>w`  | Normal | `:bd`                             | Close current buffer   |
| `<leader>bp` | Normal | `:BufferLineTogglePin`            | Pin/unpin buffer       |
| `<leader>bP` | Normal | `:BufferLineGroupClose ungrouped` | Close unpinned buffers |

---

## 📂 File Explorer (Oil.nvim)

| Keymap      | Mode   | Action | Description        |
| ----------- | ------ | ------ | ------------------ |
| `<leader>n` | Normal | `:Oil` | Open file explorer |

### Oil.nvim Navigation (In Oil Window)

- `<CR>` - Select/open file or directory
- `<C-v>` - Open in vertical split
- `<C-x>` - Open in horizontal split
- `<C-t>` - Open in new tab
- `-` - Go to parent directory
- `g.` - Toggle hidden files
- `q` or `<C-c>` - Close Oil

---

## 🌳 Symbols Outline (Aerial)

| Keymap      | Mode   | Action          | Description            |
| ----------- | ------ | --------------- | ---------------------- |
| `<leader>o` | Normal | `:AerialToggle` | Toggle symbols outline |

---

## 🔀 Git Integration

### Gitsigns (Hunk Operations)

| Keymap       | Mode            | Action          | Description               |
| ------------ | --------------- | --------------- | ------------------------- |
| `]c`         | Normal          | Next hunk       | Go to next git hunk       |
| `[c`         | Normal          | Previous hunk   | Go to previous git hunk   |
| `<leader>hs` | Normal/Visual   | Stage hunk      | Stage current hunk        |
| `<leader>hr` | Normal/Visual   | Reset hunk      | Reset current hunk        |
| `<leader>hS` | Normal          | Stage buffer    | Stage entire buffer       |
| `<leader>hu` | Normal          | Undo stage hunk | Undo staged hunk          |
| `<leader>hR` | Normal          | Reset buffer    | Reset entire buffer       |
| `<leader>hp` | Normal          | Preview hunk    | Preview hunk changes      |
| `<leader>hb` | Normal          | Blame line      | Show git blame for line   |
| `<leader>hd` | Normal          | Diff this       | Show diff                 |
| `<leader>tb` | Normal          | Toggle blame    | Toggle line blame display |
| `<leader>td` | Normal          | Toggle deleted  | Toggle deleted lines      |
| `ih`         | Operator/Visual | Select hunk     | Text object for hunk      |

### Fugitive Commands

| Keymap       | Mode   | Action           | Description    |
| ------------ | ------ | ---------------- | -------------- |
| `<leader>Gd` | Normal | `:Git diff`      | Git diff       |
| `<leader>Gb` | Normal | `:Git blame`     | Git blame      |
| `<leader>Gm` | Normal | `:Git mergetool` | Git merge tool |

---

## 🎨 Treesitter Text Objects

### Selection

| Keymap      | Mode            | Action                   | Description                   |
| ----------- | --------------- | ------------------------ | ----------------------------- |
| `<C-space>` | Visual          | Incremental selection    | Expand selection to next node |
| `<BS>`      | Visual          | Decremental selection    | Shrink selection              |
| `af`        | Operator/Visual | Select function (outer)  | Outer function text object    |
| `if`        | Operator/Visual | Select function (inner)  | Inner function text object    |
| `ac`        | Operator/Visual | Select class (outer)     | Outer class text object       |
| `ic`        | Operator/Visual | Select class (inner)     | Inner class text object       |
| `aa`        | Operator/Visual | Select parameter (outer) | Outer parameter text object   |
| `ia`        | Operator/Visual | Select parameter (inner) | Inner parameter text object   |

### Navigation

| Keymap | Mode   | Action                  | Description                 |
| ------ | ------ | ----------------------- | --------------------------- |
| `]f`   | Normal | Next function start     | Go to next function         |
| `[f`   | Normal | Previous function start | Go to previous function     |
| `]F`   | Normal | Next function end       | Go to next function end     |
| `[F`   | Normal | Previous function end   | Go to previous function end |
| `]c`   | Normal | Next class start        | Go to next class            |
| `[c`   | Normal | Previous class start    | Go to previous class        |
| `]a`   | Normal | Next parameter          | Go to next parameter        |
| `[a`   | Normal | Previous parameter      | Go to previous parameter    |

### Swap

| Keymap       | Mode   | Action                       | Description                  |
| ------------ | ------ | ---------------------------- | ---------------------------- |
| `<leader>sn` | Normal | Swap with next parameter     | Swap parameter with next     |
| `<leader>sp` | Normal | Swap with previous parameter | Swap parameter with previous |

---

## 💬 Commenting (Comment.nvim)

| Keymap | Mode   | Action               | Description                 |
| ------ | ------ | -------------------- | --------------------------- |
| `gcc`  | Normal | Toggle line comment  | Comment/uncomment line      |
| `gbc`  | Normal | Toggle block comment | Block comment line          |
| `gc`   | Visual | Toggle comment       | Comment/uncomment selection |
| `gb`   | Visual | Toggle block comment | Block comment selection     |

**Treesitter-aware**: Comments adapt to the language context!

---

## 🔄 Surround (nvim-surround)

### Add Surrounding

- `ys{motion}{char}` - Add surrounding (e.g., `ysiw"` wraps word in quotes)
- `yss{char}` - Add surrounding to entire line
- `yS{motion}{char}` - Add surrounding on new lines

### Change Surrounding

- `cs{old}{new}` - Change surrounding (e.g., `cs"'` changes " to ')
- `cS{old}{new}` - Change surrounding with new lines

### Delete Surrounding

- `ds{char}` - Delete surrounding (e.g., `ds"` removes quotes)

### Visual Mode

- `S{char}` - Add surrounding in visual mode

**Examples:**

- `ysiw"` - Surround word with "
- `cs"'` - Change " to '
- `ds{` - Delete surrounding {
- `yss)` - Surround line with ()

---

## ✅ TODO Comments (todo-comments.nvim)

| Keymap       | Mode   | Action           | Description                 |
| ------------ | ------ | ---------------- | --------------------------- |
| `]t`         | Normal | Next TODO        | Go to next TODO comment     |
| `[t`         | Normal | Previous TODO    | Go to previous TODO comment |
| `<leader>xt` | Normal | `:TodoTrouble`   | Show TODOs in Trouble       |
| `<leader>st` | Normal | `:TodoTelescope` | Search TODOs with Telescope |

**Recognized Keywords:**

- `TODO:` - Things to do
- `FIXME:` / `FIX:` / `BUG:` - Things to fix
- `HACK:` - Hacky solutions
- `WARN:` / `WARNING:` - Warnings
- `PERF:` / `OPTIMIZE:` - Performance issues
- `NOTE:` / `INFO:` - Notes and information
- `TEST:` - Test-related comments

---

## 🔍 Trouble (Better Diagnostics)

| Keymap       | Mode   | Action                              | Description                |
| ------------ | ------ | ----------------------------------- | -------------------------- |
| `<leader>xx` | Normal | `:Trouble diagnostics`              | Show all diagnostics       |
| `<leader>xX` | Normal | `:Trouble diagnostics filter.buf=0` | Buffer diagnostics         |
| `<leader>cs` | Normal | `:Trouble symbols`                  | Show symbols               |
| `<leader>cl` | Normal | `:Trouble lsp`                      | LSP definitions/references |
| `<leader>xL` | Normal | `:Trouble loclist`                  | Location list              |
| `<leader>xQ` | Normal | `:Trouble qflist`                   | Quickfix list              |

---

## 📄 Markdown Preview

| Keymap       | Mode                    | Action                   | Description             |
| ------------ | ----------------------- | ------------------------ | ----------------------- |
| `<leader>mp` | Normal (markdown files) | `:MarkdownPreviewToggle` | Toggle markdown preview |

---

## 💾 Session Management (Persistence)

| Keymap       | Mode   | Action               | Description                           |
| ------------ | ------ | -------------------- | ------------------------------------- |
| `<leader>qs` | Normal | Restore session      | Restore session for current directory |
| `<leader>ql` | Normal | Restore last session | Restore last session                  |
| `<leader>qd` | Normal | Don't save session   | Don't save current session            |

---

## 🤖 GitHub Copilot

| Keymap    | Mode   | Action              | Description                 |
| --------- | ------ | ------------------- | --------------------------- |
| `<Right>` | Insert | Accept suggestion   | Accept Copilot suggestion   |
| `<M-]>`   | Insert | Next suggestion     | Next Copilot suggestion     |
| `<M-[>`   | Insert | Previous suggestion | Previous Copilot suggestion |
| `<C-]>`   | Insert | Dismiss             | Dismiss Copilot suggestion  |
| `<M-CR>`  | Insert | Open panel          | Open Copilot panel          |

---

## ✨ Visual Mode Enhancements

| Keymap  | Mode   | Action         | Description                      |
| ------- | ------ | -------------- | -------------------------------- |
| `<`     | Visual | Indent left    | Indent left (stay in visual)     |
| `>`     | Visual | Indent right   | Indent right (stay in visual)    |
| `J`     | Visual | Move down      | Move selection down              |
| `K`     | Visual | Move up        | Move selection up                |
| `.`     | Visual | Repeat command | Repeat last command on selection |
| `<C-S>` | Visual | Sort           | Sort selection                   |

---

## 🛠️ Utility Keymaps

| Keymap       | Mode   | Action                | Description                |
| ------------ | ------ | --------------------- | -------------------------- |
| `<Esc>`      | Normal | Clear search          | Clear search highlighting  |
| `<leader>s`  | Normal | Save                  | Save current file          |
| `<leader>q`  | Normal | Quit                  | Quit current window        |
| `<leader>Q`  | Normal | Force quit all        | Force quit all windows     |
| `<leader>k`  | Normal | Show keymaps          | Show all keymaps           |
| `<leader>r`  | Normal | Show registers        | Show register contents     |
| `<leader>un` | Normal | Dismiss notifications | Dismiss all notifications  |
| `<leader>cm` | Normal | `:Mason`              | Open Mason (LSP installer) |

---

## 📦 Commands Reference

### Formatting & Linting

- `:ConformInfo` - Show conform.nvim formatter info
- `:Lint` - Manually trigger linting

### LSP & Mason

- `:Mason` - Open Mason installer
- `:MasonUpdate` - Update Mason
- `:LspInfo` - Show LSP client information
- `:LspRestart` - Restart LSP clients

### Telescope

- `:Telescope` - Open Telescope picker
- `:Telescope help_tags` - Search help tags
- `:Telescope command_history` - Command history
- `:Telescope search_history` - Search history
- `:Telescope keymaps` - Search keymaps

### Treesitter

- `:TSUpdate` - Update parsers
- `:TSInstall <language>` - Install parser
- `:TSBufToggle highlight` - Toggle highlighting

### Lazy (Plugin Manager)

- `:Lazy` - Open Lazy plugin manager
- `:Lazy sync` - Sync plugins (install/update/clean)
- `:Lazy update` - Update plugins
- `:Lazy clean` - Remove unused plugins
- `:Lazy check` - Check for updates

### Oil (File Explorer)

- `:Oil` - Open file explorer
- `:Oil <path>` - Open specific directory

### Aerial (Symbols)

- `:AerialToggle` - Toggle symbols outline
- `:AerialOpen` - Open symbols outline
- `:AerialClose` - Close symbols outline

### Git (Gitsigns)

- `:Gitsigns toggle_signs` - Toggle git signs
- `:Gitsigns toggle_linehl` - Toggle line highlight
- `:Gitsigns toggle_numhl` - Toggle number highlight
- `:Gitsigns toggle_current_line_blame` - Toggle blame

### Git (Fugitive)

- `:Git` or `:G` - Run git command
- `:Git status` - Git status
- `:Git diff` - Git diff
- `:Git blame` - Git blame
- `:Git log` - Git log
- `:Gdiffsplit` - Open diff split

### TODO Comments

- `:TodoTrouble` - Show TODOs in Trouble
- `:TodoTelescope` - Search TODOs with Telescope
- `:TodoQuickFix` - Add TODOs to quickfix

### Trouble

- `:Trouble diagnostics` - Show diagnostics
- `:Trouble symbols` - Show symbols
- `:Trouble lsp` - Show LSP info

### Markdown Preview

- `:MarkdownPreview` - Start preview
- `:MarkdownPreviewStop` - Stop preview
- `:MarkdownPreviewToggle` - Toggle preview

### Persistence (Sessions)

- `:SessionLoad` - Load session
- `:SessionSave` - Save session
- `:SessionDelete` - Delete session

### Notifications

- All notifications now use nvim-notify for better UX

---

## 🎯 Quick Reference - Most Used Keymaps

**File Operations:**

- `<leader>f` - Find files
- `<leader>g` - Live grep
- `<leader>n` - File explorer
- `<leader>s` - Save file

**LSP:**

- `K` - Hover docs
- `gd` - Go to definition
- `gr` - Go to references
- `<leader>ca` - Code actions
- `<leader>rn` - Rename
- `<leader>P` - Format

**Navigation:**

- `<C-h/j/k/l>` - Window navigation
- `<S-h/l>` - Buffer navigation
- `<C-n/p>` - Diagnostic navigation

**Git:**

- `]c` / `[c]` - Next/previous hunk
- `<leader>hs` - Stage hunk
- `<leader>hp` - Preview hunk

**Comments:**

- `gcc` - Toggle line comment
- `gc` (visual) - Toggle comment

**Surround:**

- `ysiw"` - Surround word with "
- `cs"'` - Change " to '
- `ds"` - Delete " surround

---

## 🔧 Configuration Files Structure

```
nvim/
├── init.lua                  # Bootstrap and setup
├── lua/
│   ├── config/              # Core configuration
│   │   ├── options.lua      # Neovim options
│   │   ├── keymaps.lua      # Keymaps
│   │   └── autocmds.lua     # Autocommands
│   └── plugins/             # Plugin specifications (auto-loaded by lazy.nvim)
│       ├── colorscheme.lua
│       ├── completion.lua
│       ├── copilot.lua
│       ├── editor.lua
│       ├── formatting.lua
│       ├── git.lua
│       ├── linting.lua
│       ├── lsp.lua
│       ├── markdown.lua
│       ├── persistence.lua
│       ├── telescope.lua
│       ├── todo-comments.lua
│       ├── treesitter.lua
│       ├── trouble.lua
│       ├── ui.lua
│       └── which-key.lua
└── KEYMAPS.md               # This file
```

---

## 🎨 Features Implemented

### ✅ Modern Replacements

- **FZF → Telescope.nvim** - Better fuzzy finding with LSP integration
- **vim-gitgutter → gitsigns.nvim** - Modern git integration
- **copilot.vim → copilot.lua** - Native Lua copilot

### ✅ New Features

- **Snippets** - LuaSnip with friendly-snippets
- **Formatting** - conform.nvim with format-on-save
- **Linting** - nvim-lint for additional linting
- **File Explorer** - oil.nvim (edit filesystem like buffer)
- **Comments** - Comment.nvim with treesitter context
- **Surround** - nvim-surround for text manipulation
- **Which-key** - Keymap discovery
- **Indentation guides** - indent-blankline
- **TODO highlighting** - todo-comments
- **Better diagnostics** - Trouble.nvim
- **Buffer tabs** - bufferline.nvim
- **Notifications** - nvim-notify
- **Session management** - persistence.nvim
- **Markdown preview** - markdown-preview.nvim
- **Treesitter textobjects** - Advanced code navigation

### ✅ Performance Optimizations

- Aggressive lazy loading
- Disabled unused providers
- File size limits for treesitter
- Optimized RTP

---

**Last Updated:** January 2025
**Configuration Version:** 2.0 (Comprehensive Modern Setup)
