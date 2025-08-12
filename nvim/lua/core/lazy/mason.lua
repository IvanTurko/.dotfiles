return {
  "mason-org/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
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
      "postgrestools",
      -- Formatters
      "stylua",
      "prettier",
      "pgformatter",
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
