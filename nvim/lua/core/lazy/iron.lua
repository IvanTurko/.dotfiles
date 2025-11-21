return {
  "Vigemus/iron.nvim",
  keys = {
    { "<Leader>rr", desc = "Toggle REPL" },
  },
  config = function()
    local iron = require "iron.core"
    local common = require "iron.fts.common"

    local function get_ipython_cmd()
      local python = "./.venv/bin/python"

      local handle = io.popen(string.format('%s -c "import IPython"', python))
      local success = handle and handle:close()

      if success then
        return { python, "-m", "IPython", "--no-autoindent" }
      else
        vim.notify("IPython not found in this project's .venv", vim.log.levels.WARN)
        return nil
      end
    end

    local ipython_cmd = get_ipython_cmd()

    if ipython_cmd then
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
              command = ipython_cmd,
              format = function(lines, extras)
                local result = common.bracketed_paste_python(lines, extras)
                local filtered = vim.tbl_filter(function(line)
                  return not string.match(line, "^%s*#")
                end, result)

                if filtered[#filtered] and filtered[#filtered]:match "%S" then
                  table.insert(filtered, "")
                end

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
          toggle_repl = "<Leader>rr", -- toggles the repl open and closed.
          -- If repl_open_command is a table as above, then the following keymaps are
          -- available
          -- toggle_repl_with_cmd_1 = "<Leader>rv",
          -- toggle_repl_with_cmd_2 = "<Leader>rh",
          restart_repl = "<Leader>rR", -- calls `IronRestart` to restart the repl
          send_motion = "<Leader>sc",
          visual_send = "<Leader>sc",
          send_file = "<Leader>sf",
          send_line = "<Leader>sl",
          send_paragraph = "<Leader>sp",
          send_until_cursor = "<Leader>su",
          send_mark = "<Leader>sm",
          send_code_block = "<Leader>sb",
          send_code_block_and_move = "<Leader>sn",
          mark_motion = "<Leader>mc",
          mark_visual = "<Leader>mc",
          remove_mark = "<Leader>md",
          cr = "<Leader>s<cr>",
          interrupt = "<Leader>s<Leader>",
          exit = "<Leader>sq",
          clear = "<Leader>cl",
        },
        -- If the highlight is on, you can change how it looks
        -- For the available options, check nvim_set_hl
        highlight = {
          italic = true,
        },
        ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
      }

      -- iron also has a list of commands, see :h iron-commands for all available commands
      vim.keymap.set("n", "<Leader>rf", "<cmd>IronFocus<cr>")
      vim.keymap.set("n", "<Leader>rh", "<cmd>IronHide<cr>")

      vim.keymap.set("n", "<C-x>", function()
        local core = require "iron.core"
        local ll = require "iron.lowlevel"

        local ft = ll.get_buffer_ft(0)
        if not ft then
          return
        end

        core.focus_on(ft)

        vim.defer_fn(function()
          vim.cmd "startinsert"
        end, 50)
      end, { desc = "Iron: Focus REPL and enter insert mode" })

      vim.keymap.set("t", "<C-x>", function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", false)
        vim.cmd "wincmd p"
      end, { desc = "Iron: Exit terminal and focus previous window" })
    end
  end,
}
