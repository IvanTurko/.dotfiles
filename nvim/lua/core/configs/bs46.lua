local base46 = {
  theme = "monekai_pro",
  hl_add = {
    StatusLine = { bg = "" },
  },
  hl_override = {},
  integrations = {},
  changed_themes = {},
  transparency = false,
}

base46.hl_override = {
  StatusLine = { bg = "black" },
  NormalFloat = { bg = "black" },
  FloatBorder = { bg = "black" },
  Comment = { italic = true },
  ["@comment"] = { italic = true },
  DiffChange = { bg = "#464414", fg = "none" },
  DiffAdd = { bg = "#103507", fg = "none" },
  DiffRemoved = { bg = "#461414", fg = "none" },
}

return base46
