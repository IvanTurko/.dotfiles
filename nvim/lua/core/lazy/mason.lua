return {
  "williamboman/mason.nvim",
  cmd = { "Mason", "MasonInstall", "MasonUpdate" },
  opts = {
    PATH = "skip",
    ensure_installed = {
      -- LSP
      "lua_ls",
      "gopls",
      "pyright",
      -- Formatters
      "stylua",
      "prettier",
      -- Linters
      "ruff",
    },
    ui = {
      icons = {
        package_pending = " ",
        package_installed = " ",
        package_uninstalled = " ",
      },
    },
    max_concurrent_installers = 10,
  },
}
