return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      local ts = require "nvim-treesitter"

      local ignored_parsers = {
        "org",
        "mermaid",
      }

      ts.setup {}

      local default_parsers_to_install = {
        "lua",
        "luadoc",
        "printf",
        "vim",
        "vimdoc",
        "bash",
        "python",
        "go",
        "sql",
        "http",
        "yaml",
        "json",
      }

      ts.install(default_parsers_to_install):wait(180000)

      local function is_parser_installed(filetype)
        local installed = ts.get_installed()
        for _, name in ipairs(installed) do
          if name == filetype then
            return true
          end
        end
        return false
      end

      local function is_parser_ignored(filetype)
        for _, name in ipairs(ignored_parsers) do
          if name == filetype then
            return true
          end
        end
        return false
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
          local bufnr = args.buf
          local filetype = vim.bo[bufnr].filetype

          if is_parser_ignored(filetype) then
            return
          end

          if is_parser_installed(filetype) then
            vim.treesitter.start(bufnr)
            vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          elseif filetype ~= "" and filetype ~= "text" then
            ts.install { filetype }
          end
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "TSInstall",
        callback = function()
          local bufnr = vim.api.nvim_get_current_buf()
          local filetype = vim.bo[bufnr].filetype

          if is_parser_ignored(filetype) then
            return
          end

          if is_parser_installed(filetype) and filetype ~= "" and filetype ~= "text" then
            vim.api.nvim_buf_call(bufnr, function()
              vim.cmd("doautocmd FileType " .. filetype)
            end)
          end
        end,
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "User BufInitialized",
    config = function()
      require("treesitter-context").setup {
        enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
        multiwindow = false, -- Enable multiwindow support.
        max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
        min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
        line_numbers = true,
        multiline_threshold = 20, -- Maximum number of lines to show for a single context
        trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
        mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
        -- Separator between context and content. Should be a single character string, like '-'.
        -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
        separator = nil,
        zindex = 20, -- The Z-index of the context window
        on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
      }
    end,
  },
}
