-- core/keymaps.lua

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Leader already set in options.lua

-- Buffer/File Navigation
keymap("n", "<leader>b", ":Buffers<CR>", opts)
keymap("n", "<leader>f", ":GFiles<CR>", opts)
keymap("n", "<leader>g", ":Grep ")
keymap("n", "<leader>h", ":History<CR>", opts)
keymap("n", "<leader>k", ":map<CR>", opts)
keymap("n", "<leader>n", ":Ex<CR>", opts)
-- keymap("n", "<leader>o", ":Vista!!<CR>", opts)
keymap("n", "<leader>r", ":registers<CR>", opts)
keymap("n", "<leader>s", ":w<CR>", opts)
keymap("n", "<leader>w", ":bd<CR>", opts)

-- Buffer cycling
keymap("n", "<C-j>", ":bprev<CR>", opts)
keymap("n", "<C-k>", ":bnext<CR>", opts)

-- Coc-style mappings for LSP
keymap("n", "<leader>D", vim.diagnostic.setqflist, opts)
keymap("n", "<leader>d", vim.lsp.buf.definition, opts)
keymap("n", "<leader>R", vim.lsp.buf.rename, opts)
keymap("n", "<leader>a", vim.lsp.buf.code_action, opts)
keymap("n", "<leader>P", function()
  vim.lsp.buf.format({
    filter = function(client) return client.name ~= "ts_ls" end
  })
end, opts)
keymap("n", "<C-p>", vim.diagnostic.goto_prev, opts)
keymap("n", "<C-n>", vim.diagnostic.goto_next, opts)

-- Git
keymap("n", "<leader>Gd", ":Git diff<CR>", opts)
keymap("n", "<leader>Gb", ":Git blame<CR>", opts)
keymap("n", "<leader>Gm", ":Git mergetool<CR>", opts)

-- Visual mode
keymap("v", ".", ":normal .<CR>", opts)
keymap("v", "<C-S>", "'<,'>sort<CR>", opts)

-- Copilot
keymap('i', '<Right>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false
})
vim.g.copilot_no_tab_map = true
