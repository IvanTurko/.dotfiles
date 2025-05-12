return {
  "neovim/nvim-lspconfig",
  event = "User BufInitialized",
  config = function()
    require "core.configs.lsp"
  end,
}
