return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = false,
  opts = {},
  config = function()
    require("refactoring").setup {}

    -- Visual mode
    vim.keymap.set("x", "<leader>re", ":Refactor extract", { desc = "Extract Function" })
    vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file<CR>", { desc = "Extract Function to File" })
    vim.keymap.set("x", "<leader>rv", ":Refactor extract_var<CR>", { desc = "Extract Variable" })

    -- Normal + Visual
    vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var<CR>", { desc = "Inline Variable" })

    -- Normal mode
    vim.keymap.set("n", "<leader>rI", ":Refactor inline_func<CR>", { desc = "Inline Function" })
    vim.keymap.set("n", "<leader>rb", ":Refactor extract_block<CR>", { desc = "Extract Block" })
    vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file<CR>", { desc = "Extract Block to File" })
  end,
}
