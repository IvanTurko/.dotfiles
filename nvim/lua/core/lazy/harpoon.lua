return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  keys = {
    {
      "<leader>a",
      function()
        require("harpoon"):list():add()
      end,
      desc = "Harpoon: Add file",
    },
    {
      "<C-e>",
      function()
        require("harpoon.ui"):toggle_quick_menu(require("harpoon"):list())
      end,
      desc = "Harpoon: Toggle Quick Menu",
    },
    {
      "<C-h>",
      function()
        require("harpoon"):list():select(1)
      end,
      desc = "Harpoon: Select 1",
    },
    {
      "<C-t>",
      function()
        require("harpoon"):list():select(2)
      end,
      desc = "Harpoon: Select 2",
    },
    {
      "<C-n>",
      function()
        require("harpoon"):list():select(3)
      end,
      desc = "Harpoon: Select 3",
    },
    {
      "<C-s>",
      function()
        require("harpoon"):list():select(4)
      end,
      desc = "Harpoon: Select 4",
    },
    {
      "<C-S-P>",
      function()
        require("harpoon"):list():prev()
      end,
      desc = "Harpoon: Previous",
    },
    {
      "<C-S-N>",
      function()
        require("harpoon"):list():next()
      end,
      desc = "Harpoon: Next",
    },
  },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
}
