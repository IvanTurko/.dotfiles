local base46 = {
  theme = "tomorrow_night",
  -- theme = "flexoki-light",
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

if base46.theme == "tomorrow_night" then
  base46.hl_override.NormalFloat.fg = "#c8d4c8"
  base46.hl_override.FloatBorder.fg = "#39443e"
end

base46.changed_themes = {
  tomorrow_night = {
    base_30 = {
      darker_black = "#1a1e1b",
      black = "#222b26",
      black2 = "#2a2f2b",
    },
    base_16 = {
      base00 = "#222b26",
      base08 = "#d78787",
      base0D = "#7fa5ad",
    },
  },
}

return base46
