local opt = vim.opt
local g = vim.g
local o = vim.o

g.mapleader = " "
o.mouse = ""

-- UI
opt.termguicolors = true
opt.guicursor = ""
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.fillchars = { eob = " " }
opt.splitbelow = false
opt.splitright = true

-- disable nvim intro
opt.shortmess:append "sI"

-- Statusline
opt.laststatus = 3
opt.ruler = true
opt.showmode = true

-- Line Numbers
opt.number = true
opt.relativenumber = true
opt.numberwidth = 4

-- Indenting
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.smartindent = true

-- Editing
opt.wrap = false
opt.scrolloff = 8
opt.isfname:append "@-@"

-- Search
opt.hlsearch = false
opt.incsearch = true

-- Files & Undo
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv "HOME" .. "/.vim/undodir"
opt.undofile = true

-- Timing
opt.updatetime = 50

-- Netrw
g.netrw_browse_split = 0
g.netrw_banner = 0
g.netrw_winsize = 25

-- Providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- Mason Binaries
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. ":" .. vim.env.PATH

-- Base46 cache
vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46_cache/"

vim.api.nvim_create_augroup("EnsureNumberSettings", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
  group = "EnsureNumberSettings",
  callback = function()
    if vim.bo.buftype == "" and vim.bo.modifiable then
      vim.wo.number = true
      vim.wo.relativenumber = true
    end
  end,
})