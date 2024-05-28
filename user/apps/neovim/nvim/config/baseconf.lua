--------------------------------------------------
-- Base configuration
--------------------------------------------------
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.showmode = true
vim.opt.laststatus = 2
vim.cmd('colorscheme gruvbox')

vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.autoread = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.clipboard = 'unnamedplus'

vim.keymap.set('n', '%%', ':source %<Enter>', {noremap = true})

