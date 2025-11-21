local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local ThePrimeagenGroup = augroup("ThePrimeagen", { clear = true })

autocmd("BufWritePre", {
  group = ThePrimeagenGroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

autocmd("FileType", {
  group = ThePrimeagenGroup,
  pattern = "netrw",
  callback = function()
    -- Link netrw directory classifications to Directory highlight
    vim.api.nvim_set_hl(0, "netrwClassify", { link = "Directory" })
  end,
})

local yank_group = augroup("HighlightYank", { clear = true })

autocmd("TextYankPost", {
  group = yank_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank {
      higroup = "IncSearch",
      timeout = 40,
    }
  end,
})

local org_ft_group = augroup("OrgFileTypeSettings", { clear = true })

autocmd("FileType", {
  group = org_ft_group,
  pattern = "org",
  callback = function()
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = "nc"
  end,
})

local BufInitOnce = vim.api.nvim_create_augroup("BufInitOnce", { clear = true })

autocmd({ "UIEnter", "BufReadPost", "BufNewFile" }, {
  group = BufInitOnce,
  callback = function(args)
    local file = vim.api.nvim_buf_get_name(args.buf)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    if file ~= "" and buftype ~= "nofile" then
      vim.api.nvim_exec_autocmds("User", { pattern = "BufInitialized", modeline = false })
      vim.api.nvim_del_augroup_by_name "BufInitOnce"

      vim.schedule(function()
        vim.api.nvim_exec_autocmds("FileType", {})
        if vim.g.editorconfig then
          require("editorconfig").config(args.buf)
        end
      end)
    end
  end,
})
