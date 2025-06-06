return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufNewFile" },
  keys = {
    {
      "<leader>fm",
      function()
        require("conform").format {
          lsp_fallback = true,
          timeout_ms = 500,
        }
      end,
      mode = { "n", "x" },
      desc = "general format file",
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      css = { "prettier" },
      html = { "prettier" },
      python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
    },
  },
}
