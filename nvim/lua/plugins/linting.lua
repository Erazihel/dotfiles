-- plugins/linting.lua
-- nvim-lint for additional linting beyond LSP

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      -- Code linting + spell checking
      javascript = { "eslint_d", "cspell" },
      typescript = { "eslint_d", "cspell" },
      javascriptreact = { "eslint_d", "cspell" },
      typescriptreact = { "eslint_d", "cspell" },
      vue = { "eslint_d", "cspell" },

      -- Spell checking for other code
      lua = { "cspell" },
      python = { "cspell" },
      go = { "cspell" },
      rust = { "cspell" },
      bash = { "cspell" },
      sh = { "cspell" },

      -- Markup/config files
      markdown = { "cspell" },
      json = { "cspell" },
      yaml = { "cspell" },
      html = { "cspell" },
      css = { "cspell" },
      scss = { "cspell" },
    }

    -- Configure cspell linter
    -- Pattern: ":1:9 - Unknown word (commennt)"
    local cspell_pattern = ":(%d+):(%d+) %- (.+) %((.+)%)"

    lint.linters.cspell = {
      cmd = vim.fn.stdpath("data") .. "/mason/bin/cspell",
      stdin = true,
      args = { "lint", "--no-color", "--no-progress", "--no-summary", "stdin" },
      ignore_exitcode = true,
      parser = function(output)
        local diagnostics = {}

        for line in output:gmatch("[^\r\n]+") do
          local lnum, col, message, word = line:match(cspell_pattern)
          if not lnum then goto continue end

          local col_start = tonumber(col) - 1
          table.insert(diagnostics, {
            lnum = tonumber(lnum) - 1,
            col = col_start,
            end_col = col_start + #word,
            severity = vim.diagnostic.severity.WARN,
            source = "cspell",
            message = message,
            code = word,
          })

          ::continue::
        end

        return diagnostics
      end,
    }

    -- Create autocommand for linting
    -- Note: TextChanged removed to prevent UI lag during active typing
    -- Linting still occurs on file enter, after save, and when leaving insert mode
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- Manual lint command
    vim.api.nvim_create_user_command("Lint", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })

    -- Add word to cspell dictionary
    vim.api.nvim_create_user_command("CspellAddWord", function(opts)
      local word = opts.args

      -- If no word provided, try to get it from diagnostic under cursor
      if word == "" then
        local diagnostics = vim.diagnostic.get(0, { lnum = vim.api.nvim_win_get_cursor(0)[1] - 1 })
        for _, diag in ipairs(diagnostics) do
          if diag.source == "cspell" and diag.code then
            word = diag.code
            break
          end
        end

        -- If still no word, get word under cursor
        if word == "" then
          local cursor = vim.api.nvim_win_get_cursor(0)
          local line = vim.api.nvim_get_current_line()
          local col = cursor[2]

          -- Extract word at cursor position
          local word_start = col + 1
          local word_end = col + 1

          -- Find start of word
          while word_start > 1 and line:sub(word_start - 1, word_start - 1):match("[%w_]") do
            word_start = word_start - 1
          end

          -- Find end of word
          while word_end <= #line and line:sub(word_end, word_end):match("[%w_]") do
            word_end = word_end + 1
          end

          word = line:sub(word_start, word_end - 1)
        end
      end

      if word == "" then
        vim.notify("No word found. Usage: :CspellAddWord <word> or place cursor on word", vim.log.levels.WARN)
        return
      end

      -- Use user-level cspell config file (~/.cspell.json)
      local home = vim.env.HOME or vim.env.USERPROFILE
      if not home then
        vim.notify("Could not determine home directory", vim.log.levels.ERROR)
        return
      end

      local config_path = home .. "/.cspell.json"

      -- Read config file
      local json_content = vim.fn.readfile(config_path)
      local json_text = table.concat(json_content, "\n")
      local ok, config = pcall(vim.json.decode, json_text)

      if not ok then
        vim.notify("Failed to parse .cspell.json: " .. tostring(config), vim.log.levels.ERROR)
        return
      end

      -- Ensure words array exists
      if not config.words then
        config.words = {}
      end

      -- Check if word already exists (case-insensitive)
      local word_lower = word:lower()
      local exists = false
      for _, w in ipairs(config.words) do
        if w:lower() == word_lower then
          exists = true
          break
        end
      end

      if exists then
        vim.notify("Word '" .. word .. "' already in dictionary", vim.log.levels.INFO)
        return
      end

      -- Add word and sort alphabetically
      table.insert(config.words, word)
      table.sort(config.words, function(a, b)
        return a:lower() < b:lower()
      end)

      -- Write back to file with proper formatting
      local new_json = vim.json.encode(config)
      -- Format JSON using Python's json.tool for pretty printing with 2-space indent
      local temp_file = vim.fn.tempname()
      vim.fn.writefile(vim.split(new_json, "\n"), temp_file)

      local formatted = vim.fn.system("python3 -m json.tool --indent 2 " .. vim.fn.shellescape(temp_file))
      if vim.v.shell_error ~= 0 then
        -- Fallback: try with python (without 3)
        formatted = vim.fn.system("python -m json.tool --indent 2 " .. vim.fn.shellescape(temp_file))
      end

      if vim.v.shell_error == 0 then
        vim.fn.writefile(vim.split(formatted, "\n"), config_path)
      else
        -- Last resort: write unformatted (shouldn't happen)
        vim.fn.writefile(vim.split(new_json, "\n"), config_path)
        vim.notify("Warning: Could not format JSON, file written without formatting", vim.log.levels.WARN)
      end

      -- Clean up temp file
      vim.fn.delete(temp_file)

      vim.notify("Added '" .. word .. "' to cspell dictionary", vim.log.levels.INFO)

      -- Trigger re-lint to clear the diagnostic
      lint.try_lint()
    end, { desc = "Add word to cspell dictionary", nargs = "?" })
  end,
}
