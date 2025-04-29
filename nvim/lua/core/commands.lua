-- core/commands.lua

vim.api.nvim_create_user_command("Grep", function(opts)
  local query = table.concat(opts.fargs, " ")
  local cmd = "rg --column --line-number --no-heading --color=always --hidden --smart-case -- " .. vim.fn.shellescape(query)
  vim.fn["fzf#vim#grep"](cmd, 1, vim.fn["fzf#vim#with_preview"](), opts.bang and 1 or 0)
end, {
  bang = true,
  nargs = "*",
})
