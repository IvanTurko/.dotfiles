return {
  "mason-org/mason.nvim",
  event = "VeryLazy",
  config = function()
    require("mason").setup {
      PATH = "prepend",
      ui = {
        icons = {
          package_pending = " ",
          package_installed = " ",
          package_uninstalled = " ",
        },
      },
      max_concurrent_installers = 10,
    }

    local mr = require "mason-registry"
    local packages = {
      -- LSP
      "lua-language-server",
      "gopls",
      "pyright",
      "clangd",
      -- Formatters
      "stylua",
      "prettier",
      "sqlfluff",
      -- Linters
      "ruff",
    }

    for _, tool in ipairs(packages) do
      if not mr.is_installed(tool) then
        local p = mr.get_package(tool)
        p:install()
      end
    end
  end,
}
