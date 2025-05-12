return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    defaults = {
      scroll_strategy = "cycle",
      filesize_limit = 1.0, -- MB
      mappings = {
        n = {
          ["q"] = function(buf)
            require("telescope.actions").close(buf)
          end,
        },
      },
    },
  },
  keys = {
    { "<leader>pf", desc = "Find files" },
    { "<C-p>", desc = "Find git files" },
    { "<leader>ps", desc = "Grep string" },
    { "<leader>pws", desc = "Grep word under cursor" },
    { "<leader>pWs", desc = "Grep WORD under cursor" },
    { "<leader>vh", desc = "Help tags" },
  },
  config = function(_, opts)
    require("telescope").setup(opts)

    local builtin = require "telescope.builtin"
    local map = vim.keymap.set

    map("n", "<leader>pf", builtin.find_files, { desc = "Find files" })
    map("n", "<C-p>", builtin.git_files, { desc = "Find git files" })

    map("n", "<leader>ps", function()
      builtin.grep_string { search = vim.fn.input "Grep > " }
    end, { desc = "Grep string" })

    map("n", "<leader>pws", function()
      builtin.grep_string { search = vim.fn.expand "<cword>" }
    end, { desc = "Grep word under cursor" })

    map("n", "<leader>pWs", function()
      builtin.grep_string { search = vim.fn.expand "<cWORD>" }
    end, { desc = "Grep WORD under cursor" })

    map("n", "<leader>vh", builtin.help_tags, { desc = "Help tags" })
  end,
}
