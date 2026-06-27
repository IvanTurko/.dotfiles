return {
  "mrcjkb/rustaceanvim",
  version = "^9",
  lazy = false,
  init = function()
    local lsp = require "core.configs.lsp.lspconfig"
    vim.g.rustaceanvim = {
      server = {
        on_attach = lsp.on_attach,
        on_init = lsp.on_init,
        capabilities = lsp.capabilities,
        default_settings = {
          ["rust-analyzer"] = {
            checkOnSave = true,
            check = {
              command = "clippy",
            },
          },
        },
      },
    }
  end,
}
