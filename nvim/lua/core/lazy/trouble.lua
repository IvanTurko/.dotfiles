return {
  "folke/trouble.nvim",
  opts = {
    focus = true,
    keys = {
      ["t["] = "next",
      ["t]"] = "prev",
    },
  },
  keys = {
    {
      "<leader>tt",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
  },
}
