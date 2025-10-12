return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",
    "leoluz/nvim-dap-go",
    "williamboman/mason.nvim",
  },

  keys = {
    {
      "<F5>",
      function()
        require("dap").continue()
      end,
      desc = "Debug: Start/Continue",
    },
    {
      "<F1>",
      function()
        require("dap").step_into()
      end,
      desc = "Debug: Step Into",
    },
    {
      "<F2>",
      function()
        require("dap").step_over()
      end,
      desc = "Debug: Step Over",
    },
    {
      "<F3>",
      function()
        require("dap").step_out()
      end,
      desc = "Debug: Step Out",
    },
    {
      "<leader>b",
      function()
        require("dap").toggle_breakpoint()
      end,
      desc = "Debug: Toggle Breakpoint",
    },
    {
      "<leader>B",
      function()
        require("dap").set_breakpoint(vim.fn.input "Breakpoint condition: ")
      end,
      desc = "Debug: Conditional Breakpoint",
    },
    {
      "<F7>",
      function()
        require("dapui").toggle()
      end,
      desc = "Debug: Toggle UI",
    },
  },

  config = function()
    local dap = require "dap"
    local dapui = require "dapui"

    require("mason-nvim-dap").setup {
      automatic_installation = true,
      ensure_installed = { "delve" },
    }

    local function layout(name)
      return {
        elements = { { id = name } },
        enter = true,
        size = 65,
        position = "right",
      }
    end

    local name_to_layout = {
      repl = { layout = layout "repl", index = 0 },
      stacks = { layout = layout "stacks", index = 0 },
      scopes = { layout = layout "scopes", index = 0 },
      console = { layout = layout "console", index = 0 },
      watches = { layout = layout "watches", index = 0 },
      breakpoints = { layout = layout "breakpoints", index = 0 },
    }

    local layouts = {}
    for name, cfg in pairs(name_to_layout) do
      table.insert(layouts, cfg.layout)
      name_to_layout[name].index = #layouts
    end

    dapui.setup {
      layouts = layouts,
      icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
    }

    vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
    vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
    local icons = vim.g.have_nerd_font
        and {
          Breakpoint = "",
          BreakpointCondition = "",
          BreakpointRejected = "",
          LogPoint = "",
          Stopped = "",
        }
      or {
        Breakpoint = "●",
        BreakpointCondition = "⊜",
        BreakpointRejected = "⊘",
        LogPoint = "◆",
        Stopped = "⭔",
      }
    for type, icon in pairs(icons) do
      local hl = (type == "Stopped") and "DapStop" or "DapBreak"
      vim.fn.sign_define("Dap" .. type, { text = icon, texthl = hl, numhl = hl })
    end

    local function toggle_ui(name)
      local cfg = name_to_layout[name]
      if not cfg then
        vim.notify("No layout found for " .. name, vim.log.levels.ERROR)
        return
      end
      dapui.close()
      pcall(dapui.toggle, cfg.index)
    end

    local function register_debug_keymaps()
      vim.keymap.set("n", "<leader>dr", function()
        toggle_ui "repl"
      end, { desc = "Debug: toggle repl ui" })
      vim.keymap.set("n", "<leader>ds", function()
        toggle_ui "stacks"
      end, { desc = "Debug: toggle stacks ui" })
      vim.keymap.set("n", "<leader>dw", function()
        toggle_ui "watches"
      end, { desc = "Debug: toggle watches ui" })
      vim.keymap.set("n", "<leader>db", function()
        toggle_ui "breakpoints"
      end, { desc = "Debug: toggle breakpoints ui" })
      vim.keymap.set("n", "<leader>dv", function()
        toggle_ui "scopes"
      end, { desc = "Debug: toggle scopes ui" })
      vim.keymap.set("n", "<leader>dc", function()
        toggle_ui "console"
      end, { desc = "Debug: toggle console ui" })
    end

    dap.listeners.after.event_initialized["register_debug_keymaps"] = function()
      register_debug_keymaps()
    end
    dap.listeners.before.event_terminated["dapui_config"] = dapui.close
    dap.listeners.before.event_exited["dapui_config"] = dapui.close

    require("dap-go").setup {}
  end,
}
