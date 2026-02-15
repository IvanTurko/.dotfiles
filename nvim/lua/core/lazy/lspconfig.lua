return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "j-hui/fidget.nvim" },
  config = function()
    require "core.configs.lsp"
  end,
}
