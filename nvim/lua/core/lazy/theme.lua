return {
  {
    "nvchad/base46",
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
    opts = function()
      return {
        default_icon = { icon = "󰈚", name = "Default" },
        js = { icon = "󰌞", name = "js" },
        ts = { icon = "󰛦", name = "ts" },
        lock = { icon = "󰌾", name = "lock" },
        ["robots.txt"] = { icon = "󰚩", name = "robots" },
      }
    end,
  },
}
