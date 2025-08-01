-- cd $HOME/.local/share/nvim/lazy/base46/lua/base46/themes

local M = {}

M.base_30 = {
  white = "#f2fffc",
  darker_black = "#222a2e",
  black = "#273136", -- nvim bg
  black2 = "#2e3a3f",
  one_bg = "#303b41",
  one_bg2 = "#38444a",
  one_bg3 = "#404c52",
  grey = "#6b7678",
  grey_fg = "#7d888a",
  grey_fg2 = "#8e999b",
  light_grey = "#9da8aa",
  red = "#ff6d7e",
  baby_pink = "#ff9dab",
  pink = "#ff6d7e",
  line = "#303a3f",
  green = "#a2e57b",
  vibrant_green = "#b3f593",
  nord_blue = "#7cd5f1",
  blue = "#7cd5f1",
  yellow = "#ffed72",
  sun = "#fff599",
  purple = "#baa0f8",
  dark_purple = "#a488e0",
  teal = "#7cd5f1",
  orange = "#ffb270",
  cyan = "#7cd5f1",
  statusline_bg = "#2e3a3f",
  lightbg = "#38444a",
  pmenu_bg = "#a2e57b",
  folder_bg = "#7cd5f1",
}

M.base_16 = {
  base00 = "#273136", -- background
  base01 = "#2e3a3f",
  base02 = "#38444a",
  base03 = "#545f62", -- selection bg
  base04 = "#6b7678",
  base05 = "#f2fffc", -- foreground
  base06 = "#f2fffc", -- bright white
  base07 = "#ffffff",
  base08 = "#ff6d7e", -- red
  base09 = "#ffb270", -- orange
  base0A = "#ffed72", -- yellow
  base0B = "#a2e57b", -- green
  base0C = "#7cd5f1", -- cyan
  base0D = "#7cd5f1", -- blue
  base0E = "#baa0f8", -- purple
  base0F = "#ff6d7e",
}

M.polish_hl = {
  treesitter = {
    ["parameter"] = { fg = M.base_30.blue },
    ["@variable.member.key"] = { fg = M.base_30.white },
    ["@string"] = { fg = M.base_30.sun },
    ["@boolean"] = { fg = M.base_16.base09 },
    ["@punctuation.bracket"] = { fg = M.base_30.sun },
    ["@operator"] = { fg = M.base_30.red },
  },

  syntax = {
    Operator = { fg = M.base_30.red },
  },

  defaults = {
    FloatBorder = {
      bg = M.base_30.black,
      fg = "#6b7678",
    },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "custom_palette")

return M
