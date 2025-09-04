return {
  "uga-rosa/translate.nvim",
  keys = {
    { "<Leader>lt", ":Translate RU<CR>", mode = "n", desc = "Translate word under cursor" },
    { "<Leader>lt", ":Translate RU<CR>", mode = "x", desc = "Translate selected text" },
  },
  config = function()
    require("translate").setup {}

    vim.keymap.set(
      "n",
      "<Leader>lt",
      "viw:Translate RU<CR>",
      { noremap = true, silent = true, desc = "Translate word under cursor" }
    )
    vim.keymap.set(
      "x",
      "<Leader>lt",
      ":Translate RU<CR>",
      { noremap = true, silent = true, desc = "Translate selected text" }
    )
  end,
}
