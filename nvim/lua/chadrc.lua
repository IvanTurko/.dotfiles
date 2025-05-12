local M = {}

local theme = require "core.configs.ui.theme"

M.ui = {
  cmp = {
    icons_left = false, -- only for non-atom styles!
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    abbr_maxwidth = 60,
    -- for tailwind, css lsp etc
    format_colors = { lsp = true, icon = "󱓻" },
  },
  tabufline = {
    enabled = false,
  },
  statusline = {
    enabled = true,
    theme = "minimal",
    separator_style = "round",
  },
}

M.base46 = {
  theme = theme.name,
  changed_themes = theme.changed_themes,
  hl_override = theme.hl_override,
}

M.lsp = {
  signature = false,
}

M.nvdash = require "core.configs.ui.nvdash"

return M
