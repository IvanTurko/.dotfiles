local M = {}
local fn = vim.fn
local base46_path = vim.fn.fnamemodify(debug.getinfo(require("base46").merge_tb, "S").source:sub(2), ":p:h")

M.list_themes = function()
  local default_themes = vim.fn.readdir(base46_path .. "/themes")
  local custom_themes = vim.uv.fs_stat(fn.stdpath "config" .. "/lua/themes")

  if custom_themes and custom_themes.type == "directory" then
    local themes_tb = fn.readdir(fn.stdpath "config" .. "/lua/themes")
    for _, value in ipairs(themes_tb) do
      table.insert(default_themes, value)
    end
  end

  for index, theme in ipairs(default_themes) do
    default_themes[index] = theme:match "(.+)%..+"
  end

  return default_themes
end

M.replace_word = function(old, new, filepath)
  filepath = filepath or vim.fn.stdpath "config" .. "/lua/core/configs/" .. "bs46.lua"

  local file = io.open(filepath, "r")
  if file then
    local added_pattern = string.gsub(old, "-", "%%-") -- add % before - if exists
    local new_content = file:read("*all"):gsub(added_pattern, new)

    file = io.open(filepath, "w")
    file:write(new_content)
    file:close()
  end
end

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local previewers = require "telescope.previewers"

local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_set = require "telescope.actions.set"
local action_state = require "telescope.actions.state"

local function reload_theme(name)
  require("nvconfig").base46.theme = name
  require("plenary.reload").reload_module "base46"
  require("base46").load_all_highlights()
end

local function switcher()
  local bufnr = vim.api.nvim_get_current_buf()

  -- show current buffer content in previewer
  local previewer = previewers.new_buffer_previewer {
    define_preview = function(self, entry)
      -- add content
      local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
      vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)

      -- add syntax highlighting in previewer
      local ft = (vim.filetype.match { buf = bufnr } or "diff"):match "%w+"
      require("telescope.previewers.utils").highlighter(self.state.bufnr, ft)
    end,
  }

  package.loaded["core.configs.bs46"] = nil
  local theme_at_start = require("core.configs.bs46").theme

  -- our picker function: colors
  local picker = pickers.new {
    previewer = previewer,
    finder = finders.new_table {
      results = M.list_themes(),
    },
    sorter = conf.generic_sorter(),

    attach_mappings = function(prompt_bufnr)
      -- reload theme while typing
      vim.schedule(function()
        vim.api.nvim_create_autocmd("TextChangedI", {
          buffer = prompt_bufnr,
          callback = function()
            if action_state.get_selected_entry() then
              reload_theme(action_state.get_selected_entry()[1])
            end
          end,
        })
      end)
      -- reload theme on cycling
      actions.move_selection_previous:replace(function()
        action_set.shift_selection(prompt_bufnr, -1)
        reload_theme(action_state.get_selected_entry()[1])
      end)
      actions.move_selection_next:replace(function()
        action_set.shift_selection(prompt_bufnr, 1)
        reload_theme(action_state.get_selected_entry()[1])
      end)

      ------------ save theme to chadrc on enter ----------------
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        if entry then
          M.replace_word('"' .. theme_at_start .. '"', '"' .. entry[1] .. '"')
          actions.close(prompt_bufnr)
        end
      end)
      return true
    end,
  }

  picker:find()
end

return require("telescope").register_extension {
  exports = { themes = switcher },
}
