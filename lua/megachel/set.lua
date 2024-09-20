vim.opt.nu = true

vim.opt.clipboard = "unnamedplus"
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.backup = false
local is_windows = vim.loop.os_uname().version:match("Windows")

if is_windows then
  vim.opt.undodir = os.getenv('USERPROFILE') .. '\\.vim\\undodir'
else
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'
end
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true


vim.opt.scrolloff = 6
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append('@-@')

vim.opt.updatetime = 50

vim.g.mapleader = " "
