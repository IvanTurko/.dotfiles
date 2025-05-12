return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "fredrikaverpil/neotest-golang",
    "leoluz/nvim-dap-go",
  },
  keys = {
    {
      "<leader>tr",
      function()
        require("neotest").run.run()
      end,
      desc = "Run Nearest Test",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand "%")
      end,
      desc = "Run Tests in Current File",
    },
    {
      "<leader>ts",
      function()
        require("neotest").run.run(vim.fn.getcwd())
      end,
      desc = "Run All Tests in Project",
    },
    {
      "<leader>td",
      function()
        require("neotest").run.run { strategy = "dap" }
      end,
      desc = "Debug Nearest Test",
    },
    {
      "<leader>tv",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle Summary",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open()
      end,
      desc = "Open Test Output",
    },
    {
      "<leader>ta",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle Output Panel",
    },
  },
  config = function()
    require("neotest").setup {
      adapters = {
        require "neotest-golang",
      },
    }
  end,
}
