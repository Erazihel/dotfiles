-- plugins/dap.lua
-- Debug Adapter Protocol for JS/TS (Node.js)

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup()

          -- Auto-open UI when debugging starts; close manually with <leader>du
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
        end,
      },
      { "theHamsta/nvim-dap-virtual-text", opts = {} },
      {
        "microsoft/vscode-js-debug",
        version = "1.x",
        build = "npm install --legacy-peer-deps && npx gulp dapDebugServer && git checkout package-lock.json",
      },
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue / Start" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval expression", mode = { "n", "v" } },
    },
    init = function()
      -- Derive DapStoppedLine from Catppuccin palette
      local ok, palette = pcall(function()
        return require("catppuccin.palettes").get_palette("macchiato")
      end)
      if ok and palette then
        vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = palette.surface0 })
      else
        vim.api.nvim_set_hl(0, "DapStoppedLine", { link = "Visual" })
      end
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "◆", texthl = "DiagnosticWarn", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = "○", texthl = "DiagnosticError", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "DapStoppedLine", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = "◇", texthl = "DiagnosticInfo", numhl = "" })
    end,
    config = function()
      local dap = require("dap")
      local js_debug_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"

      -- dapDebugServer.js uses the standard DAP startDebugging reverse request
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = { js_debug_path .. "/dist/src/dapDebugServer.js", "${port}" },
        },
      }

      local skip_files = { "<node_internals>/**", "**/node_modules/**" }

      -- JavaScript configurations
      for _, language in ipairs({ "javascript", "javascriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            skipFiles = skip_files,
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            skipFiles = skip_files,
          },
        }
      end

      -- TypeScript configurations (Node.js native type stripping)
      for _, language in ipairs({ "typescript", "typescriptreact" }) do
        dap.configurations[language] = {
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            runtimeArgs = { "--experimental-strip-types" },
            skipFiles = skip_files,
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach to process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            skipFiles = skip_files,
          },
        }
      end
    end,
  },
}
