local map = vim.keymap.set

map("n", "<leader>e", "<cmd>Oil<CR>")
-- map("n", "<leader>e", vim.cmd.Ex)
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Exit from Insert Mode" })

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Substitute word under cursor" })

map("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
map("n", "n", "nzzzv", { desc = "Next search result centered" })
map("n", "N", "Nzzzv", { desc = "Prev search result centered" })
map("n", "=ap", "ma=ap'a", { desc = "Format around paragraph" })

map("x", "<leader>s", function()
  local saved_reg = vim.fn.getreg '"'

  vim.cmd 'normal! "vy'

  local selection = vim.fn.escape(vim.fn.getreg '"', [[\/]])
  vim.fn.setreg('"', saved_reg)

  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(":%s/" .. selection .. "/", true, false, true), "n", false)
end, { desc = "Substitute visual selection (prompt for replacement)" })

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- next greatest remap ever : asbjornHaland
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])

-- Tmux navigation

-- map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "Tmux navigate left" })
-- map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "Tmux navigate down" })
-- map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "Tmux navigate up" })
-- map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "Tmux navigate right" })
-- map("n", "<C-\\>", "<cmd>TmuxNavigatePrevious<CR>", { desc = "Tmux navigate previous" })

-- Telescope
map("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "telescope diagnostics" })

map("n", "<C-k>", "<cmd>cnext<CR>zz")
map("n", "<C-j>", "<cmd>cprev<CR>zz")
map("n", "<leader>k", "<cmd>lnext<CR>zz")
map("n", "<leader>j", "<cmd>lprev<CR>zz")

map("n", "<leader>th", function()
  require("plenary.reload").reload_module "base46"
  require("base46").load_all_highlights()
  vim.notify "Reload My Theme"
end, { desc = "reload theme" })

map("n", "<leader>tn", function()
  require("base46").toggle_theme()
  require("plenary.reload").reload_module "base46"
  require("base46").load_all_highlights()
  vim.notify "Toogle My Theme"
end, { desc = "toggle theme" })

map("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")
