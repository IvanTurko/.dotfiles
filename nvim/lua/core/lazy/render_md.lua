return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown" },
  opts = {
    heading = {
      icons = {},
      backgrounds = {},
    },
    pipe_table = {
      head = "RenderMarkdownTableRow",
    },
    code = {
      disable_background = true,
      inline = false,
      language_icon = false,
      highlight_border = false,
    },
    anti_conceal = {
      ignore = {
        code_background = false, -- default: true (already always shown)
        code_border = true, -- default: false (hidden when cursor moves away)
        code_language = true, -- default: false (hidden when cursor moves away)
      },
    },
  },
}
