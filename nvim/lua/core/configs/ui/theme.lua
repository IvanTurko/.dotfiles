local theme = {}

theme.name = "tomorrow_night"

theme.changed_themes = {
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

theme.hl_override = {
  NormalFloat = { bg = "black" },
  FloatBorder = { bg = "black" },
  Comment = { italic = true },
  ["@comment"] = { italic = true },
  DiffChange = { bg = "#464414", fg = "none" },
  DiffAdd = { bg = "#103507", fg = "none" },
  DiffRemoved = { bg = "#461414", fg = "none" },
}

if theme.name == "tomorrow_night" then
  theme.hl_override.NormalFloat.fg = "#c8d4c8"
  theme.hl_override.FloatBorder.fg = "#39443e"
  theme.hl_override.NvDashFooter = { fg = "#6e8894" }
  vim.api.nvim_create_autocmd("User", {
    pattern = "Base46Done",
    callback = function()
      local colors = { "#f1fa8c", "#00bfff" }
      local c = colors[math.random(#colors)]
      vim.api.nvim_set_hl(0, "NvDashAscii", { fg = c })
    end,
  })
end

return theme
