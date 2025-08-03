return {
  "Vigemus/iron.nvim",
  keys = {
    { "<space>rr", desc = "Toggle REPL" },
  },
  config = function()
    local iron = require "iron.core"
    local common = require "iron.fts.common"

    local function get_poetry_ipython()
      local handle = io.popen "poetry run which ipython 2>/dev/null"
      if handle then
        local result = handle:read("*a"):gsub("\n", "")
        handle:close()
        if result ~= "" then
          return result
        end
      end
      return "ipython" -- fallback
    end

    local ipython_path = get_poetry_ipython()

    iron.setup {
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          sh = {
            -- Can be a table or a function that
            -- returns a table (see below)
            command = { "zsh" },
          },
          python = {
            command = { ipython_path, "--no-autoindent" },
            format = function(lines, extras)
              local result = common.bracketed_paste_python(lines, extras)
              local filtered = vim.tbl_filter(function(line)
                return not string.match(line, "^%s*#") and line:match "%S"
              end, result)
              return filtered
            end,
            block_dividers = { "# %%", "#%%" },
          },
        },
        -- set the file type of the newly created repl to ft
        -- bufnr is the buffer id of the REPL and ft is the filetype of the
        -- language being used for the REPL.
        repl_filetype = function(_, ft)
          return ft
          -- or return a string name such as the following
          -- return "iron"
        end,
        repl_open_cmd = "vertical split",
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        toggle_repl = "<space>rr", -- toggles the repl open and closed.
        -- If repl_open_command is a table as above, then the following keymaps are
        -- available
        -- toggle_repl_with_cmd_1 = "<space>rv",
        -- toggle_repl_with_cmd_2 = "<space>rh",
        restart_repl = "<space>rR", -- calls `IronRestart` to restart the repl
        send_motion = "<space>sc",
        visual_send = "<space>sc",
        send_file = "<space>sf",
        send_line = "<space>sl",
        send_paragraph = "<space>sp",
        send_until_cursor = "<space>su",
        send_mark = "<space>sm",
        send_code_block = "<space>sb",
        send_code_block_and_move = "<space>sn",
        mark_motion = "<space>mc",
        mark_visual = "<space>mc",
        remove_mark = "<space>md",
        cr = "<space>s<cr>",
        interrupt = "<space>s<space>",
        exit = "<space>sq",
        clear = "<space>cl",
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    }

    -- iron also has a list of commands, see :h iron-commands for all available commands
    vim.keymap.set("n", "<space>rf", "<cmd>IronFocus<cr>")
    vim.keymap.set("n", "<space>rh", "<cmd>IronHide<cr>")
  end,
}
