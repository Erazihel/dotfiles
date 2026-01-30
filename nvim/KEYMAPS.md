# Neovim Configuration Reference

Complete reference for this Neovim configuration. All keymaps, plugins, features, and commands.

**Leader Key:** `<Space>`
**Local Leader:** `\`

---

## Table of Contents

- [Essential Vim Motions](#essential-vim-motions)
- [File Navigation & Search (FZF)](#file-navigation--search-fzf)
- [Flash (Fast Navigation)](#flash-fast-navigation)
- [LSP (Language Server Protocol)](#lsp-language-server-protocol)
- [Completion (nvim-cmp)](#completion-nvim-cmp)
- [Window Management](#window-management)
- [Buffer Management](#buffer-management)
- [Terminal](#terminal)
- [File Explorer (Neo-tree)](#file-explorer-neo-tree)
- [Symbols Outline (Aerial)](#symbols-outline-aerial)
- [Git Integration](#git-integration)
- [Treesitter Text Objects](#treesitter-text-objects)
- [Commenting](#commenting-built-in)
- [Surround](#surround-nvim-surround)
- [Find & Replace (grug-far)](#find--replace-grug-far)
- [Diagnostics (Trouble)](#diagnostics-trouble)
- [TODO Comments](#todo-comments)
- [Copilot](#github-copilot)
- [Debug (nvim-dap)](#debug-nvim-dap)
- [Harpoon (File Bookmarks)](#harpoon-file-bookmarks)
- [Folding (nvim-ufo)](#folding-nvim-ufo)
- [Test Runner (Neotest)](#test-runner-neotest)
- [Enhanced Text Objects (mini.ai)](#enhanced-text-objects-miniai)
- [Auto Tag (nvim-ts-autotag)](#auto-tag-nvim-ts-autotag)
- [Color Previews (Colorizer)](#color-previews-colorizer)
- [Diffview](#diffview)
- [Formatting & Linting](#formatting--linting)
- [Spell Checking (cspell)](#spell-checking-cspell)
- [Markdown](#markdown)
- [Session Management](#session-management-persistence)
- [Visual Mode Enhancements](#visual-mode-enhancements)
- [Utility](#utility)
- [Commands Reference](#commands-reference)
- [Configuration Structure](#configuration-structure)
- [Plugin List](#plugin-list)

---

## Essential Vim Motions

These are built-in Vim motions that are NOT part of this config, but are essential to know.

### Basic Movement

| Key                 | Description                     |
| ------------------- | ------------------------------- |
| `h` `j` `k` `l`     | Left, Down, Up, Right           |
| `w` / `W`           | Next word / WORD start          |
| `b` / `B`           | Previous word / WORD start      |
| `e` / `E`           | Next word / WORD end            |
| `0` / `$`           | Start / End of line             |
| `^`                 | First non-blank character       |
| `gg` / `G`          | Top / Bottom of file            |
| `{count}G`          | Go to line number               |
| `{` / `}`           | Previous / Next paragraph       |
| `%`                 | Jump to matching bracket        |
| `H` / `M` / `L`     | Top / Middle / Bottom of screen |
| `Ctrl-d` / `Ctrl-u` | Half page down / up             |
| `Ctrl-f` / `Ctrl-b` | Full page down / up             |

### Search

| Key        | Description                                 |
| ---------- | ------------------------------------------- |
| `/pattern` | Search forward                              |
| `?pattern` | Search backward                             |
| `n` / `N`  | Next / Previous match                       |
| `*` / `#`  | Search word under cursor forward / backward |

### Operators (combine with motions)

| Key            | Description                                           |
| -------------- | ----------------------------------------------------- |
| `d{motion}`    | Delete (e.g., `dw` = delete word, `dd` = delete line) |
| `c{motion}`    | Change (delete + insert mode)                         |
| `y{motion}`    | Yank (copy)                                           |
| `>` / `<`      | Indent / Outdent (in visual mode or with motion)      |
| `.`            | Repeat last change                                    |
| `u` / `Ctrl-r` | Undo / Redo                                           |

### Insert Mode Entry

| Key       | Description                  |
| --------- | ---------------------------- |
| `i` / `a` | Insert before / after cursor |
| `I` / `A` | Insert at line start / end   |
| `o` / `O` | Open new line below / above  |
| `ciw`     | Change inner word            |
| `ci"`     | Change inside quotes         |

### Marks & Jumps

| Key                 | Description                  |
| ------------------- | ---------------------------- |
| `m{a-z}`            | Set local mark               |
| `` `{a-z} ``        | Jump to mark                 |
| `Ctrl-o` / `Ctrl-i` | Jump list backward / forward |

---

## File Navigation & Search (fzf-lua)

Uses `ibhagwan/fzf-lua` for fast fuzzy finding with devicons and rounded borders.

| Keymap      | Mode   | Description             |
| ----------- | ------ | ----------------------- |
| `<leader>f` | Normal | Find git files          |
| `<leader>F` | Normal | Find all files          |
| `<leader>G` | Normal | Live grep (interactive) |
| `<leader>b` | Normal | Find open buffers       |
| `<leader>H` | Normal | Recent file history     |

### Inside FZF Window

| Key      | Description                  |
| -------- | ---------------------------- |
| `Ctrl-p` | Toggle preview               |
| `Enter`  | Open selected file           |
| `Ctrl-t` | Open in new tab              |
| `Ctrl-x` | Open in horizontal split     |
| `Ctrl-v` | Open in vertical split       |
| `Ctrl-q` | Send all results to quickfix |
| `Esc`    | Close FZF                    |

The Grep command uses ripgrep with `--hidden --smart-case` and excludes `node_modules/`, `.git/`, `dist/`, and `build/`.

---

## Flash (Fast Navigation)

Uses `folke/flash.nvim` for quick jumping to any visible location.

| Keymap | Mode                     | Description                               |
| ------ | ------------------------ | ----------------------------------------- |
| `s`    | Normal, Visual, Operator | Flash jump (type chars, then label)       |
| `S`    | Normal, Visual, Operator | Flash Treesitter (select by syntax node)  |
| `r`    | Operator                 | Remote Flash (operate on remote location) |
| `R`    | Operator, Visual         | Treesitter search                         |

Enhanced `f`/`F`/`t`/`T` motions are also active (char mode).

### How to Use Flash

1. Press `s` in normal mode
2. Type 1-2 characters you want to jump to
3. Labels appear on all matches - press the label key to jump

---

## LSP (Language Server Protocol)

Keymaps become available when an LSP server attaches to the buffer.

### Navigation

| Keymap | Mode   | Description           |
| ------ | ------ | --------------------- |
| `gd`   | Normal | Go to definition      |
| `gD`   | Normal | Go to declaration     |
| `gr`   | Normal | Go to references      |
| `gi`   | Normal | Go to implementation  |
| `gy`   | Normal | Go to type definition |

### Documentation

| Keymap   | Mode   | Description         |
| -------- | ------ | ------------------- |
| `K`      | Normal | Hover documentation |
| `Ctrl-k` | Insert | Signature help      |

### Actions

| Keymap      | Mode   | Description   |
| ----------- | ------ | ------------- |
| `<leader>a` | Normal | Code action   |
| `<leader>R` | Normal | Rename symbol (incremental preview) |

### Diagnostics

| Keymap      | Mode   | Description                  |
| ----------- | ------ | ---------------------------- |
| `]d`        | Normal | Next diagnostic              |
| `[d`        | Normal | Previous diagnostic          |
| `<leader>D` | Normal | Send diagnostics to quickfix |

Diagnostics display as sign column dots and underlines. No inline virtual text. Floating diagnostic automatically appears on `CursorHold` when the cursor is on a line with diagnostics.

LSP progress (indexing, loading) is shown via fidget.nvim in the bottom-right corner.

### Installed LSP Servers

Managed by Mason, auto-installed:
`bashls`, `cssls`, `dockerls`, `eslint`, `graphql`, `html`, `jsonls`, `lua_ls`, `ts_ls`, `vimls`, `yamlls`

---

## Completion (nvim-cmp)

Completion menu appears automatically in insert mode.

| Keymap              | Mode   | Description                                         |
| ------------------- | ------ | --------------------------------------------------- |
| `Tab`               | Insert | Next completion item / Expand snippet               |
| `Shift-Tab`         | Insert | Previous completion item / Previous snippet field   |
| `Ctrl-Space`        | Insert | Trigger completion manually                         |
| `Enter`             | Insert | Confirm selected item (must be explicitly selected) |
| `Ctrl-e`            | Insert | Abort completion                                    |
| `Ctrl-b` / `Ctrl-f` | Insert | Scroll docs up / down                               |

### Completion Sources (Priority Order)

1. **LSP** - Language server suggestions
2. **LuaSnip** - Snippet expansions (friendly-snippets library)
3. **Buffer** - Words from current buffer (3+ chars)
4. **Path** - File paths

### Command-Line Completion

- `:` commands: Path completion + cmdline completion
- `/` and `?` search: Buffer word completion

---

## Window Management

### Navigation

| Keymap   | Mode   | Description           |
| -------- | ------ | --------------------- |
| `Ctrl-h` | Normal | Move to left window   |
| `Ctrl-j` | Normal | Move to bottom window |
| `Ctrl-k` | Normal | Move to top window    |
| `Ctrl-l` | Normal | Move to right window  |

### Resizing

| Keymap       | Mode   | Description            |
| ------------ | ------ | ---------------------- |
| `Ctrl-Up`    | Normal | Increase window height |
| `Ctrl-Down`  | Normal | Decrease window height |
| `Ctrl-Left`  | Normal | Decrease window width  |
| `Ctrl-Right` | Normal | Increase window width  |

### Built-in Window Commands

| Key              | Description                              |
| ---------------- | ---------------------------------------- |
| `Ctrl-w s`       | Split horizontal                         |
| `Ctrl-w v`       | Split vertical                           |
| `Ctrl-w c`       | Close window                             |
| `Ctrl-w o`       | Close all other windows                  |
| `Ctrl-w =`       | Equalize window sizes                    |
| `Ctrl-w H/J/K/L` | Move window to far left/bottom/top/right |

---

## Buffer Management

| Keymap      | Mode   | Description                                     |
| ----------- | ------ | ----------------------------------------------- |
| `Shift-h`   | Normal | Previous buffer                                 |
| `Shift-l`   | Normal | Next buffer                                     |
| `<leader>w` | Normal | Close current buffer (smart - handles Neo-tree) |

No buffer tabs are shown (tabline disabled). Use `<leader>b` to see open buffers via FZF.

---

## Terminal

| Keymap         | Mode     | Description                                             |
| -------------- | -------- | ------------------------------------------------------- |
| `Ctrl-/`       | Normal   | Open terminal in horizontal split (`Ctrl-_` also works) |
| `Ctrl-\`       | Terminal | Exit terminal mode (back to normal mode)                |
| `Ctrl-h/j/k/l` | Terminal | Navigate to other windows from terminal                 |

To move the terminal to a vertical split: `Ctrl-w L`

---

## File Explorer (Neo-tree)

| Keymap      | Mode   | Description             |
| ----------- | ------ | ----------------------- |
| `<leader>e` | Normal | Toggle Neo-tree sidebar |

### Inside Neo-tree

| Key         | Description                       |
| ----------- | --------------------------------- |
| `Enter`     | Open file                         |
| `s`         | Open in vertical split            |
| `S`         | Open in horizontal split          |
| `t`         | Open in new tab                   |
| `P`         | Toggle floating preview           |
| `a`         | Add file                          |
| `A`         | Add directory                     |
| `d`         | Delete                            |
| `r`         | Rename                            |
| `y`         | Copy to clipboard                 |
| `x`         | Cut to clipboard                  |
| `p`         | Paste from clipboard              |
| `c`         | Copy file                         |
| `m`         | Move file                         |
| `C`         | Close node                        |
| `z`         | Close all nodes                   |
| `H`         | Toggle hidden files               |
| `/`         | Fuzzy finder                      |
| `R`         | Refresh                           |
| `q`         | Close Neo-tree                    |
| `?`         | Show help                         |
| `[g` / `]g` | Previous / Next git modified file |

### Ordering

| Key  | Description          |
| ---- | -------------------- |
| `oc` | Order by created     |
| `od` | Order by diagnostics |
| `og` | Order by git status  |
| `om` | Order by modified    |
| `on` | Order by name        |
| `os` | Order by size        |
| `ot` | Order by type        |

Neo-tree follows the current file, shows git status, hides `node_modules` and `.DS_Store`.

---

## Symbols Outline (Aerial)

| Keymap      | Mode   | Description                   |
| ----------- | ------ | ----------------------------- |
| `<leader>o` | Normal | Toggle Aerial symbols outline |

### Inside Aerial

| Key       | Description                   |
| --------- | ----------------------------- |
| `Enter`   | Jump to symbol                |
| `Ctrl-v`  | Jump in vertical split        |
| `Ctrl-s`  | Jump in horizontal split      |
| `p`       | Scroll to symbol (don't jump) |
| `l` / `h` | Open / Close tree node        |
| `o`       | Toggle tree node              |
| `q`       | Close Aerial                  |

---

## Git Integration

### Hunk Navigation

| Keymap | Mode   | Description       |
| ------ | ------ | ----------------- |
| `]c`   | Normal | Next git hunk     |
| `[c`   | Normal | Previous git hunk |

### Hunk Operations (`<leader>gh`)

| Keymap        | Mode          | Description         |
| ------------- | ------------- | ------------------- |
| `<leader>ghs` | Normal/Visual | Stage hunk          |
| `<leader>ghr` | Normal/Visual | Reset hunk          |
| `<leader>ghS` | Normal        | Stage entire buffer |
| `<leader>ghu` | Normal        | Undo stage hunk     |
| `<leader>ghR` | Normal        | Reset entire buffer |
| `<leader>ghp` | Normal        | Preview hunk        |
| `<leader>ghd` | Normal        | Diff this ~         |

### Git Commands (`<leader>g`)

| Keymap       | Mode   | Description              |
| ------------ | ------ | ------------------------ |
| `<leader>gB` | Normal | Blame line (full)        |
| `<leader>gD` | Normal | Diff this                |
| `<leader>gd` | Normal | Git diff (fugitive)      |
| `<leader>gb` | Normal | Git blame (fugitive)     |
| `<leader>gm` | Normal | Git mergetool (fugitive) |
| `<leader>gv` | Normal | Open diffview            |
| `<leader>gV` | Normal | Close diffview           |
| `<leader>gf` | Normal | Current file history     |
| `<leader>gF` | Normal | Full branch history      |

### Git Toggles (`<leader>gt`)

| Keymap        | Mode   | Description          |
| ------------- | ------ | -------------------- |
| `<leader>gtb` | Normal | Toggle line blame    |
| `<leader>gtd` | Normal | Toggle deleted lines |

### Git Text Object

| Keymap | Mode            | Description |
| ------ | --------------- | ----------- |
| `ih`   | Operator/Visual | Select hunk |

---

## Treesitter Text Objects

### Selection

| Keymap      | Mode            | Description             |
| ----------- | --------------- | ----------------------- |
| `af` / `if` | Operator/Visual | Outer / Inner function  |
| `ac` / `ic` | Operator/Visual | Outer / Inner class     |
| `aa` / `ia` | Operator/Visual | Outer / Inner parameter |

### Navigation

| Keymap      | Mode   | Description                    |
| ----------- | ------ | ------------------------------ |
| `]f` / `[f` | Normal | Next / Previous function start |
| `]F` / `[F` | Normal | Next / Previous function end   |
| `]a` / `[a` | Normal | Next / Previous parameter      |
| `]A` / `[A` | Normal | Next / Previous parameter end  |

### Swap

| Keymap        | Mode   | Description                  |
| ------------- | ------ | ---------------------------- |
| `<leader>csn` | Normal | Swap parameter with next     |
| `<leader>csp` | Normal | Swap parameter with previous |

---

## Commenting (Built-in)

Neovim 0.10+ built-in commenting with treesitter-aware `commentstring`.

| Keymap | Mode   | Description                       |
| ------ | ------ | --------------------------------- |
| `gcc`  | Normal | Toggle line comment               |
| `gc`   | Visual | Toggle comment on selection       |

---

## Surround (nvim-surround)

### Add

| Command            | Description                                       |
| ------------------ | ------------------------------------------------- |
| `ys{motion}{char}` | Add surrounding (e.g., `ysiw"` wraps word in `"`) |
| `yss{char}`        | Surround entire line                              |

### Change

| Command        | Description                                          |
| -------------- | ---------------------------------------------------- |
| `cs{old}{new}` | Change surrounding (e.g., `cs"'` changes `"` to `'`) |

### Delete

| Command    | Description                                     |
| ---------- | ----------------------------------------------- |
| `ds{char}` | Delete surrounding (e.g., `ds"` removes quotes) |

### Visual

| Command   | Description               |
| --------- | ------------------------- |
| `S{char}` | Surround visual selection |

---

## Find & Replace (grug-far)

| Keymap       | Mode   | Description            |
| ------------ | ------ | ---------------------- |
| `<leader>St` | Normal | Toggle search/replace  |
| `<leader>Sw` | Normal | Search current word    |
| `<leader>Sw` | Visual | Search selection       |
| `<leader>Sf` | Normal | Search in current file |

grug-far provides an interactive buffer for search and replace across files. See `:h grug-far` for keymaps inside the grug-far buffer.

---

## Diagnostics (Trouble)

| Keymap       | Mode   | Description                       |
| ------------ | ------ | --------------------------------- |
| `<leader>xx` | Normal | Toggle all diagnostics            |
| `<leader>xX` | Normal | Toggle buffer diagnostics         |
| `<leader>xs` | Normal | Toggle symbols                    |
| `<leader>xl` | Normal | Toggle LSP definitions/references |
| `<leader>xL` | Normal | Toggle location list              |
| `<leader>xQ` | Normal | Toggle quickfix list              |

---

## TODO Comments

Highlights `TODO:`, `FIXME:`, `HACK:`, `WARN:`, `PERF:`, `NOTE:`, `TEST:` in comments.

| Keymap       | Mode   | Description                    |
| ------------ | ------ | ------------------------------ |
| `]t`         | Normal | Next TODO comment              |
| `[t`         | Normal | Previous TODO comment          |
| `<leader>xt` | Normal | Show TODOs in Trouble          |
| `<leader>xT` | Normal | Show TODO/FIX/FIXME in Trouble |

---

## GitHub Copilot

Inline suggestions appear automatically in insert mode.

| Keymap      | Mode   | Description         |
| ----------- | ------ | ------------------- |
| `Right`     | Insert | Accept suggestion   |
| `Alt-]`     | Insert | Next suggestion     |
| `Alt-[`     | Insert | Previous suggestion |
| `Ctrl-]`    | Insert | Dismiss suggestion  |
| `Alt-Enter` | Insert | Open Copilot panel  |

### In Copilot Panel

| Key         | Description                |
| ----------- | -------------------------- |
| `Enter`     | Accept suggestion          |
| `]]` / `[[` | Next / Previous suggestion |
| `gr`        | Refresh                    |

Copilot is disabled for: help, gitcommit, gitrebase, hgcommit, svn, cvs files.

---

## Debug (nvim-dap)

Full debugger for Node.js and Chrome/Firefox via `nvim-dap` + `nvim-dap-ui`.

| Keymap      | Mode          | Description              |
| ----------- | ------------- | ------------------------ |
| `<leader>db` | Normal       | Toggle breakpoint        |
| `<leader>dB` | Normal       | Conditional breakpoint   |
| `<leader>dc` | Normal       | Continue / Start         |
| `<leader>di` | Normal       | Step into                |
| `<leader>do` | Normal       | Step over                |
| `<leader>dO` | Normal       | Step out                 |
| `<leader>dt` | Normal       | Terminate                |
| `<leader>du` | Normal       | Toggle DAP UI            |
| `<leader>de` | Normal/Visual | Eval expression          |

### Debug Configurations

Each JS/TS filetype has three configurations available:
- **Launch file** — run the current file with Node.js
- **Attach to process** — attach to a running Node.js process
- **Launch Chrome** — open Chrome to localhost:3000 for client-side debugging

The DAP UI auto-opens when debugging starts.

---

## Harpoon (File Bookmarks)

Quick file bookmarking with `ThePrimeagen/harpoon` v2.

| Keymap      | Mode   | Description           |
| ----------- | ------ | --------------------- |
| `<leader>ha` | Normal | Add file to harpoon  |
| `<leader>hh` | Normal | Toggle harpoon menu  |
| `<leader>1` | Normal | Jump to harpoon file 1 |
| `<leader>2` | Normal | Jump to harpoon file 2 |
| `<leader>3` | Normal | Jump to harpoon file 3 |
| `<leader>4` | Normal | Jump to harpoon file 4 |

Use `<leader>ha` to mark frequently-used files, then `<leader>1-4` to jump instantly.

---

## Folding (nvim-ufo)

Enhanced folding with virtual text previews via `nvim-ufo`. Uses treesitter with indent fallback.

| Keymap | Mode   | Description           |
| ------ | ------ | --------------------- |
| `zR`   | Normal | Open all folds        |
| `zM`   | Normal | Close all folds       |
| `zr`   | Normal | Open folds by level   |
| `zm`   | Normal | Close folds by level  |
| `zp`   | Normal | Preview fold contents |

Folds show a virtual text summary with line count. All folds are open by default (`foldlevel=99`).

---

## Test Runner (Neotest)

Run Jest and Vitest tests from within Neovim via `neotest`.

| Keymap       | Mode   | Description            |
| ------------ | ------ | ---------------------- |
| `<leader>tn` | Normal | Run nearest test       |
| `<leader>tf` | Normal | Run current file tests |
| `<leader>tl` | Normal | Run last test          |
| `<leader>to` | Normal | Toggle output panel    |
| `<leader>tS` | Normal | Toggle test summary    |

Test results appear as inline virtual text (pass/fail indicators).

---

## Enhanced Text Objects (mini.ai)

`mini.ai` extends built-in text objects with treesitter-aware variants.

| Text Object | Description                           |
| ----------- | ------------------------------------- |
| `af` / `if` | Around / Inside function (treesitter) |
| `ac` / `ic` | Around / Inside class (treesitter)    |
| `ao` / `io` | Around / Inside block/conditional/loop |
| `aq` / `iq` | Around / Inside any quote             |
| `ab` / `ib` | Around / Inside any bracket           |

These work with all operators: `d`, `c`, `y`, `v`, etc. For example, `daf` deletes an entire function, `ciq` changes inside any quote type.

---

## Auto Tag (nvim-ts-autotag)

Automatically closes and renames HTML/JSX/TSX/Vue tags via treesitter. No keymaps needed -- works automatically in insert mode.

- Type `<div>` and the closing `</div>` is inserted
- Rename an opening tag and the closing tag updates to match

---

## Color Previews (Colorizer)

Shows inline color swatches next to color values in CSS, SCSS, HTML, JS/TS, and Vue files. Supports hex, `rgb()`, `hsl()`, CSS named colors, and Tailwind classes.

No keymaps -- activates automatically. Colors display as virtual text squares (■).

---

## Diffview

Full file-by-file diff viewer and merge conflict resolution UI.

| Keymap       | Mode   | Description          |
| ------------ | ------ | -------------------- |
| `<leader>gv` | Normal | Open diffview        |
| `<leader>gV` | Normal | Close diffview       |
| `<leader>gf` | Normal | Current file history |
| `<leader>gF` | Normal | Full branch history  |

### Inside Diffview

Use standard vim motions to navigate. Press `g?` for help within the diffview panel. The file panel on the left shows changed files; select one to see its diff.

### Commands

| Command                  | Description                |
| ------------------------ | -------------------------- |
| `:DiffviewOpen`          | Open diff against index    |
| `:DiffviewOpen HEAD~2`   | Diff against 2 commits ago |
| `:DiffviewOpen main`     | Diff against main branch   |
| `:DiffviewFileHistory %` | History for current file   |
| `:DiffviewFileHistory`   | History for entire repo    |
| `:DiffviewClose`         | Close diffview             |

---

## Formatting & Linting

### Formatting (conform.nvim)

Runs asynchronously after save.

| Language          | Formatter           |
| ----------------- | ------------------- |
| Lua               | stylua              |
| JS/TS/JSX/TSX/Vue | eslint_d + prettier |
| CSS/SCSS/Less     | prettier            |
| HTML              | prettier            |
| JSON/JSONC        | prettier            |
| YAML              | prettier            |
| Markdown          | prettier            |
| GraphQL           | prettier            |
| Bash/Shell        | shfmt               |

| Command        | Description           |
| -------------- | --------------------- |
| `:Format`      | Format current buffer |
| `:Format!`     | Format async          |
| `:ConformInfo` | Show formatter info   |

### Linting (nvim-lint)

Runs on `BufReadPost`, `BufWritePost`, and `InsertLeave`.

| Command | Description              |
| ------- | ------------------------ |
| `:Lint` | Manually trigger linting |

---

## Spell Checking (cspell)

cspell runs as a linter on all major file types.

| Keymap       | Mode   | Description                                |
| ------------ | ------ | ------------------------------------------ |
| `<leader>Aw` | Normal | Add word under cursor to cspell dictionary |

Also accepts: `:CspellAddWord <word>`

Dictionary is stored at `~/.cspell.json`.

---

## Markdown

| Keymap       | Mode              | Description                        |
| ------------ | ----------------- | ---------------------------------- |
| `<leader>mp` | Normal (markdown) | Toggle markdown preview in browser |
| `<leader>mr` | Normal (markdown) | Toggle inline render-markdown      |

Two markdown tools: `markdown-preview.nvim` opens a live browser preview, `render-markdown.nvim` renders headings, checkboxes, tables, and code blocks inline in the buffer.

---

## Session Management (Persistence)

| Keymap       | Mode   | Description                           |
| ------------ | ------ | ------------------------------------- |
| `<leader>qs` | Normal | Restore session for current directory |
| `<leader>ql` | Normal | Restore last session                  |
| `<leader>qd` | Normal | Don't save current session            |
| `<leader>qS` | Normal | Select a session to load              |

---

## Visual Mode Enhancements

| Keymap    | Mode   | Description                              |
| --------- | ------ | ---------------------------------------- |
| `<` / `>` | Visual | Indent left/right (stays in visual mode) |
| `J`       | Visual | Move selection down                      |
| `K`       | Visual | Move selection up                        |
| `.`       | Visual | Repeat last command on each line         |
| `Ctrl-S`  | Visual | Sort selection                           |

---

## Utility

| Keymap       | Mode   | Description               |
| ------------ | ------ | ------------------------- |
| `Esc`        | Normal | Clear search highlight    |
| `<leader>s`  | Normal | Save file                 |
| `<leader>k`  | Normal | Show all keymaps          |
| `<leader>r`  | Normal | Show registers            |
| `<leader>cf` | Normal | Format current buffer     |
| `<leader>ud` | Normal | Toggle diagnostics        |
| `<leader>un` | Normal | Dismiss all notifications |
| `<leader>pm` | Normal | Open Mason                |

### Snacks.nvim

| Keymap | Mode   | Description                                  |
| ------ | ------ | -------------------------------------------- |
| `]r`   | Normal | Next word reference (highlight under cursor) |
| `[r`   | Normal | Previous word reference                      |

Snacks also provides: better `vim.ui.input`, big file handling, and quick file opening. `vim.ui.select` is handled by fzf-lua.

---

## Which-Key Groups

Press `<leader>` and wait to see all available keymaps.

| Prefix       | Group              |
| ------------ | ------------------ |
| `<leader>A`  | Add (cspell)       |
| `<leader>c`  | Code               |
| `<leader>d`  | Debug              |
| `<leader>g`  | Git                |
| `<leader>gh` | Git hunks          |
| `<leader>gt` | Git toggles        |
| `<leader>h`  | Harpoon            |
| `<leader>m`  | Markdown           |
| `<leader>p`  | Packages           |
| `<leader>q`  | Session            |
| `<leader>cs` | Code swap          |
| `<leader>t`  | Test               |
| `<leader>S`  | Search/Replace     |
| `<leader>u`  | User Interface     |
| `<leader>x`  | Diagnostics        |

---

## Commands Reference

### Plugin Management (Lazy)

| Command        | Description                        |
| -------------- | ---------------------------------- |
| `:Lazy`        | Open plugin manager                |
| `:Lazy sync`   | Install, update, and clean plugins |
| `:Lazy update` | Update plugins                     |
| `:Lazy check`  | Check for updates                  |

### LSP & Mason

| Command        | Description             |
| -------------- | ----------------------- |
| `:Mason`       | Open Mason installer    |
| `:MasonUpdate` | Update Mason            |
| `:LspInfo`     | Show active LSP clients |
| `:LspRestart`  | Restart LSP clients     |

### FZF

| Command   | Description |
| --------- | ----------- |
| `:FzfLua` | Open picker |

### Treesitter

| Command                  | Description         |
| ------------------------ | ------------------- |
| `:TSUpdate`              | Update all parsers  |
| `:TSInstall <lang>`      | Install parser      |
| `:TSBufToggle highlight` | Toggle highlighting |

### Git (Fugitive)

| Command        | Description        |
| -------------- | ------------------ |
| `:Git` or `:G` | Open git status    |
| `:Git diff`    | Git diff           |
| `:Git blame`   | Git blame          |
| `:Git log`     | Git log            |
| `:Gdiffsplit`  | Open diff in split |

### Trouble

| Command                | Description      |
| ---------------------- | ---------------- |
| `:Trouble diagnostics` | All diagnostics  |
| `:Trouble symbols`     | Document symbols |
| `:Trouble lsp`         | LSP references   |
| `:TodoTrouble`         | TODO comments    |

### Aerial

| Command         | Description            |
| --------------- | ---------------------- |
| `:AerialToggle` | Toggle symbols outline |
| `:AerialOpen`   | Open outline           |
| `:AerialClose`  | Close outline          |

### Markdown

| Command                  | Description    |
| ------------------------ | -------------- |
| `:MarkdownPreview`       | Start preview  |
| `:MarkdownPreviewStop`   | Stop preview   |
| `:MarkdownPreviewToggle` | Toggle preview |

### Copilot

| Command    | Description         |
| ---------- | ------------------- |
| `:Copilot` | Open Copilot status |

---

## Autocommands

These run automatically:

| Event                               | Action                                                 |
| ----------------------------------- | ------------------------------------------------------ |
| `CursorHold`                        | Show diagnostic float (only on lines with diagnostics) |
| `TextYankPost`                      | Highlight yanked text                                  |
| `FocusGained`                       | Auto-reload changed files                              |
| `VimResized`                        | Equalize split sizes                                   |
| FileType: `qf`, `help`, `man`, etc. | Press `q` to close                                     |
| FileType: `gitcommit`, `markdown`   | Enable wrap and spell                                  |

---

## Configuration Structure

```
nvim/
├── init.lua                    # Bootstrap lazy.nvim, set leader keys, disable providers
├── KEYMAPS.md                  # This file
└── lua/
    ├── config/
    │   ├── options.lua         # Neovim settings (numbers, tabs, search, UI, etc.)
    │   ├── keymaps.lua         # Core keymaps (navigation, buffers, terminal, visual)
    │   ├── autocmds.lua        # Autocommands (diagnostics, filetypes, buffer management)
    │   └── utils.lua           # Shared utilities (format_json)
    └── plugins/                # Auto-loaded by lazy.nvim
        ├── colorscheme.lua     # Catppuccin (macchiato)
        ├── completion.lua      # nvim-cmp + LuaSnip + sources
        ├── copilot.lua         # GitHub Copilot (inline suggestions)
        ├── dap.lua             # nvim-dap + dap-ui + vscode-js-debug
        ├── editor.lua          # flash.nvim, surround, Neo-tree, Aerial, mini.ai
        ├── formatting.lua      # conform.nvim (format after save)
        ├── fzf.lua             # fzf-lua fuzzy finder + vim.ui.select
        ├── git.lua             # gitsigns + vim-fugitive + diffview
        ├── harpoon.lua         # Harpoon 2 file bookmarks
        ├── linting.lua         # nvim-lint + cspell config + CspellAddWord command
        ├── lsp.lua             # lspconfig + mason + lazydev.nvim + fidget + inc-rename
        ├── markdown.lua        # Markdown preview + render-markdown
        ├── neotest.lua         # Neotest + Jest + Vitest adapters
        ├── persistence.lua     # Session management
        ├── snacks.lua          # QoL: ui.input, notifier, bigfile, words highlight
        ├── search-replace.lua  # Find and replace across files (grug-far)
        ├── todo-comments.lua   # Highlight TODO/FIXME/etc.
        ├── treesitter.lua      # Treesitter + textobjects + autotag
        ├── trouble.lua         # Better diagnostics list
        ├── ufo.lua             # nvim-ufo enhanced folding
        ├── ui.lua              # devicons, indent-blankline, lualine, colorizer
        └── which-key.lua       # Keymap discovery (press leader and wait)
```

---

## Plugin List

| Plugin                        | Purpose                                       |
| ----------------------------- | --------------------------------------------- |
| lazy.nvim                     | Plugin manager                                |
| catppuccin                    | Colorscheme (macchiato flavor)                |
| nvim-lspconfig                | LSP client configuration                      |
| mason.nvim                    | LSP/tool installer                            |
| mason-lspconfig.nvim          | Bridge between mason and lspconfig            |
| lazydev.nvim                  | Lua development environment for Neovim        |
| nvim-cmp                      | Autocompletion                                |
| cmp-nvim-lsp                  | LSP completion source                         |
| cmp-buffer                    | Buffer completion source                      |
| cmp-path                      | Path completion source                        |
| cmp-cmdline                   | Command-line completion source                |
| LuaSnip                       | Snippet engine                                |
| friendly-snippets             | Snippet collection                            |
| nvim-treesitter               | Syntax highlighting and code understanding    |
| nvim-treesitter-textobjects   | Code-aware text objects and navigation        |
| nvim-ts-autotag               | Auto close/rename HTML/JSX/Vue tags           |
| nvim-colorizer.lua            | Inline color previews for CSS/HTML            |
| diffview.nvim                 | File-by-file diff viewer and merge resolution |
| fidget.nvim                   | LSP progress indicator                        |
| conform.nvim                  | Formatting                                    |
| nvim-lint                     | Linting (cspell)                              |
| fzf-lua                       | Fuzzy finder + vim.ui.select                  |
| neo-tree.nvim                 | File explorer sidebar                         |
| aerial.nvim                   | Symbols outline                               |
| gitsigns.nvim                 | Git signs, hunk operations                    |
| vim-fugitive                  | Git commands                                  |
| nvim-surround                 | Surround text manipulation                    |
| flash.nvim                    | Fast jump navigation                          |
| snacks.nvim                   | QoL utilities (ui.input, notifier, bigfile, words) |
| trouble.nvim                  | Better diagnostics list                       |
| todo-comments.nvim            | Highlight and search TODOs                    |
| grug-far.nvim                 | Find and replace across files                 |
| copilot.lua                   | GitHub Copilot                                |
| nvim-dap                      | Debug Adapter Protocol                        |
| nvim-dap-ui                   | Debugger UI                                   |
| nvim-dap-vscode-js            | JS/TS debug adapter (Node + Chrome)           |
| harpoon                       | Quick file bookmarks (v2)                     |
| nvim-ufo                      | Enhanced folding with virtual text previews   |
| inc-rename.nvim               | Incremental LSP rename with live preview      |
| render-markdown.nvim          | Inline markdown rendering in buffer           |
| neotest                       | Test runner framework                         |
| neotest-jest                  | Jest adapter for neotest                      |
| neotest-vitest                | Vitest adapter for neotest                    |
| mini.ai                       | Enhanced text objects (treesitter-aware)       |
| which-key.nvim                | Keymap discovery                              |
| lualine.nvim                  | Statusline                                    |
| indent-blankline.nvim         | Indent guides                                 |
| nvim-web-devicons             | File icons                                    |
| markdown-preview.nvim         | Markdown preview in browser                   |
| persistence.nvim              | Session management                            |
| nui.nvim                      | UI component library                          |

---

## Notable Options

| Option           | Value         | Description                                   |
| ---------------- | ------------- | --------------------------------------------- |
| `number`         | `true`        | Show line numbers                             |
| `relativenumber` | `true`        | Relative line numbers                         |
| `expandtab`      | `true`        | Spaces instead of tabs                        |
| `shiftwidth`     | `2`           | 2-space indentation                           |
| `smartcase`      | `true`        | Case-insensitive search unless uppercase used |
| `clipboard`      | `unnamedplus` | System clipboard integration                  |
| `undofile`       | `true`        | Persistent undo                               |
| `scrolloff`      | `8`           | Keep 8 lines visible above/below cursor       |
| `updatetime`     | `300`         | Faster CursorHold (diagnostic floats)         |
| `laststatus`     | `3`           | Global statusline                             |
| `wrap`           | `false`       | No line wrapping                              |
| `signcolumn`     | `yes`         | Always show sign column                       |
