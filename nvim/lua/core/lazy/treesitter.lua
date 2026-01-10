return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = "User BufInitialized",
    branch = "main",
    build = ":TSUpdate",
    config = function()
      local ts = require "nvim-treesitter"

      local ignored_parsers = {
        "mermaid",
      }

      ts.setup {}

      -- WARNING: Treesitter compilation is RAM-heavy!
      -- If Neovim freezes/crashes during installation (especially on 'gitcommit'):
      -- 1. Check Swap space (must be > 4GB total memory): `free -h`
      -- 2. If low RAM, install manually without optimization using this command in terminal:
      --    CC="gcc -O0" nvim then after ":TSInstall gitcommit"
      local default_parsers_to_install = {
        "lua",
        "luadoc",
        "printf",
        "vim",
        "vimdoc",
        "bash",
        "python",
        "go",
        "c",
        "cpp",
        "sql",
        "http",
        "yaml",
        "json",
        "gitcommit", -- Heavy to compile! See warning above.
      }

      ts.install(default_parsers_to_install):wait(180000)

      local available_parsers = {}
      for _, lang in ipairs(ts.get_available()) do
        available_parsers[lang] = true
      end

      local function is_parser_available(filetype)
        return available_parsers[filetype] == true
      end

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

      local function activate_treesitter_in_buffers(target_filetype)
        vim.defer_fn(function()
          local installed_parsers = ts.get_installed()
          local installed_map = {}
          for _, name in ipairs(installed_parsers) do
            installed_map[name] = true
          end

          for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
            if not vim.api.nvim_buf_is_valid(bufnr) then
              goto continue
            end

            if not vim.api.nvim_buf_is_loaded(bufnr) then
              goto continue
            end

            local filetype = vim.bo[bufnr].filetype

            if filetype == target_filetype and installed_map[filetype] and not is_parser_ignored(filetype) then
              vim.api.nvim_buf_call(bufnr, function()
                vim.cmd("doautocmd FileType " .. filetype)
              end)
            end
            ::continue::
          end
        end, 50)
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
          elseif filetype ~= "" and filetype ~= "text" and is_parser_available(filetype) then
            vim.schedule(function()
              ts.install({ filetype }):wait(30000)
              activate_treesitter_in_buffers(filetype)
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
