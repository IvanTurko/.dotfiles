return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = { -- set to setup table
    user_default_options = {
      names = false, -- "Name" codes like Blue or red.  Added from `vim.api.nvim_get_color_map()`
      -- Highlighting mode.  'background'|'foreground'|'virtualtext'
      mode = "virtualtext", -- Set the display mode
      -- Virtualtext character to use
      virtualtext = "▇▇",
      -- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
      virtualtext_inline = "before",
      -- Virtualtext highlight mode: 'background'|'foreground'
      virtualtext_mode = "foreground",
      -- update color values even if buffer is not focused
      -- example use: cmp_menu, cmp_docs
      always_update = false,
      RGB = false, -- #RGB hex codes
      RGBA = false, -- #RGBA hex codes
      -- hooks to invert control of colorizer
      hooks = {
        -- called before line parsing.  Accepts boolean or function that returns boolean
        -- see hooks section below
        disable_line_highlight = false,
      },
    },
  },
}
