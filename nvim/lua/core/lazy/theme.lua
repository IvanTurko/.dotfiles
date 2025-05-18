return {
  {
    "vague2k/vague.nvim",
    lazy = false,
    config = function()
      require("vague").setup {
        colors = {
          bg = "#222b26",
          line = "#2a2f2b",
          error = "#d78787",
        },
        transparent = true
      }

      vim.cmd "colorscheme vague"
      vim.cmd ":hi statusline guibg=NONE"
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "netrw",
        callback = function()
          vim.api.nvim_set_hl(0, "netrwClassify", { link = "Directory" })
        end,
      })
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
