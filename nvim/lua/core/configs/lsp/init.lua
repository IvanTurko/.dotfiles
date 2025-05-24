local prefix = "core.configs.lsp"
local lspconfig = require(prefix .. ".lspconfig")
local config = vim.lsp.config

lspconfig.diagnostic_config()
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    lspconfig.on_attach(_, args.buf)
  end,
})

local lsp_list = { "lua_ls", "gopls", "pyright" }

config("*", {
  on_init = lspconfig.on_init,
  capabilities = lspconfig.capabilities,
})

config("lua_ls", {
  settings = {
    Lua = {
      workspace = {
        library = {
          vim.fn.expand "$VIMRUNTIME/lua",
          vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy",
          "${3rd}/luv/library",
        },
      },
    },
  },
})

config("gopls", {
  on_init = nil,
  settings = {
    gopls = {
      gofumpt = true,
      usePlaceholders = false,
      staticcheck = false,
      analyses = {
        unusedparams = true,
        nilness = true,
        unusedwrite = true,
      },
    },
  },
  flags = { debounce_text_changes = 150 },
})

config("pyright", {
  settings = {
    python = {
      analysis = {
        diagnosticMode = "workspace",
      },
    },
  },
})

for _, lsp in ipairs(lsp_list) do
  vim.lsp.enable(lsp)
end
