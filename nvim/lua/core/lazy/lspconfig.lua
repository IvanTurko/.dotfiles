return {
  "neovim/nvim-lspconfig",
  event = "User BufInitialized",
  dependencies = { "j-hui/fidget.nvim" },
  config = function()
    require "core.configs.lsp"
  end,
}
