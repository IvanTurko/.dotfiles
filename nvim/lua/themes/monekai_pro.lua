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

  orgmode = {
    -- Headlines
    ["@org.headline.level1.org"] = { fg = M.base_30.purple },
    ["@org.headline.level2.org"] = { fg = M.base_30.blue },
    ["@org.headline.level3.org"] = { fg = M.base_30.cyan },
    ["@org.headline.level4.org"] = { fg = M.base_30.green },
    ["@org.headline.level5.org"] = { fg = M.base_30.yellow },
    ["@org.headline.level6.org"] = { fg = M.base_30.orange },
    ["@org.headline.level7.org"] = { fg = M.base_30.sun },
    ["@org.headline.level8.org"] = { fg = M.base_30.pink },

    -- Priorities
    ["@org.priority.highest"] = { fg = M.base_30.red, bold = true },

    -- Timestamps
    ["@org.timestamp.active"] = { fg = M.base_30.teal },
    ["@org.timestamp.inactive"] = { fg = M.base_30.grey_fg },

    -- Keywords (TODO / DONE / Plans)
    ["@org.keyword.todo"] = { fg = M.base_30.red, bold = true },
    ["@org.keyword.done"] = { fg = M.base_30.vibrant_green, bold = true },
    ["@org.plan"] = { fg = M.base_30.orange },

    -- Bullets, tags, drawers
    ["@org.bullet"] = { fg = M.base_30.sun },
    ["@org.tag"] = { fg = M.base_30.grey_fg2, bold = true },
    ["@org.properties"] = { fg = M.base_30.grey_fg },
    ["@org.drawer"] = { fg = M.base_30.grey_fg2 },

    -- Blocks
    ["@org.block"] = { fg = M.base_30.grey, italic = true },
    ["@org.inline_block"] = { fg = M.base_30.grey, italic = true },
    ["@org.comment"] = { fg = M.base_30.grey_fg, italic = true },
    ["@org.directive"] = { fg = M.base_30.grey_fg2, italic = true },
    ["@org.latex_env"] = { fg = M.base_30.sun },

    -- Checkboxes
    ["@org.checkbox"] = { fg = M.base_30.grey },
    ["@org.checkbox.checked"] = { fg = M.base_30.vibrant_green, bold = true },
    ["@org.checkbox.unchecked"] = { fg = M.base_30.grey },
    ["@org.checkbox.halfchecked"] = { fg = M.base_30.yellow },

    -- Inline text styles
    ["@org.bold"] = { bold = true },
    ["@org.bold.delimiter"] = { bold = true },
    ["@org.italic"] = { italic = true },
    ["@org.italic.delimiter"] = { italic = true },
    ["@org.strikethrough"] = { strikethrough = true },
    ["@org.strikethrough.delimiter"] = { strikethrough = true },
    ["@org.underline"] = { underline = true },
    ["@org.underline.delimiter"] = { underline = true },

    -- Inline code
    ["@org.code"] = { fg = M.base_30.green },
    ["@org.code.delimiter"] = { fg = M.base_30.green },
    ["@org.verbatim"] = { fg = M.base_30.orange },
    ["@org.verbatim.delimiter"] = { fg = M.base_30.orange },

    -- Hyperlinks
    ["@org.hyperlink"] = { fg = M.base_30.cyan, underline = true },
    ["@org.hyperlink.url"] = { fg = M.base_30.teal, underline = true },
    ["@org.hyperlink.desc"] = { fg = M.base_30.blue, underline = true },

    -- LaTeX
    ["@org.latex"] = { fg = M.base_30.sun },

    -- Tables
    ["@org.table.delimiter"] = { fg = M.base_30.grey },
    ["@org.table.heading"] = { fg = M.base_30.blue, bold = true },

    -- Edit special buffer
    ["@org.edit_src"] = { bg = M.base_30.one_bg2 },

    -- Agenda
    ["@org.agenda.deadline"] = { fg = M.base_30.red },
    ["@org.agenda.scheduled"] = { fg = M.base_30.vibrant_green },
    ["@org.agenda.scheduled_past"] = { fg = M.base_30.orange },
    ["@org.agenda.day"] = { fg = M.base_30.yellow },
    ["@org.agenda.today"] = { fg = M.base_30.purple, bold = true },
    ["@org.agenda.weekend"] = { fg = M.base_30.blue, bold = true },
  },
}

M.type = "dark"

M = require("base46").override_theme(M, "custom_palette")

return M
