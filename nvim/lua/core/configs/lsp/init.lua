local prefix = "core.configs.lsp"
local lspconfig = require(prefix .. ".lspconfig")
local config = vim.lsp.config

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    lspconfig.on_attach(_, args.buf)
  end,
})

local lsp_list = {
  "lua_ls",
  "gopls",
  "clangd",
  "pyright",
}

-- LSP configuration priority rules (Neovim 0.11+, vim.lsp.config)
--
-- Configurations are merged in the following order (lowest → highest priority):
-- 1. config("*", { … })          → your global defaults (on_init, capabilities, etc.)
-- 2. Built-in nvim-lspconfig defaults for the specific server (lua/lspconfig/server_configurations/*.lua)
-- 3. config("<server>", { … })   → your per-server overrides (wins everything)
--
-- Merging uses vim.tbl_deep_extend("force") → the last write wins.
-- That’s why:
--   • gopls needs on_init = nil — otherwise its built-in on_init forcibly adds a bunch of default settings
--   • clangd only needs cmd with --background-index — everything else comes from the project’s .clangd file
--   • global on_init/capabilities are inherited by every server unless explicitly overridden

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

config("clangd", {
  cmd = {
    "clangd",
    "--background-index",
  },
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
