--------------------------------------------------
-- Keymaps
--------------------------------------------------
vim.g.mapleader = '-';
vim.g.maplocalleader = '-';

vim.keymap.set('i', 'jj', '<Esc>', {noremap = true })

vim.keymap.set('n', '<C-s>', ':w<Enter>', {noremap = true })
vim.keymap.set('n', '<C-c>', ':wq<Enter>', {noremap = true })
vim.keymap.set('n', '<C-x>', ':q!<Enter>', {noremap = true })
vim.keymap.set('i', '<C-s>', '<Esc>:w<Enter>', {noremap = true })
vim.keymap.set('i', '<C-c>', '<Esc>:wq<Enter>', {noremap = true })
vim.keymap.set('i', '<C-x>', '<Esc>:q!<Enter>', {noremap = true })

vim.keymap.set('n', '<C-h>', '<C-w>h', {noremap = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', {noremap = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', {noremap = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', {noremap = true })
vim.keymap.set('i', '<C-h>', '<C-w>h', {noremap = true })
vim.keymap.set('i', '<C-j>', '<C-w>j', {noremap = true })
vim.keymap.set('i', '<C-k>', '<C-w>k', {noremap = true })
vim.keymap.set('i', '<C-l>', '<C-w>l', {noremap = true })

vim.keymap.set('n', '<C-t>', openTerminalWindow, {noremap = true })
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', {noremap = true })
vim.keymap.set('t', '<C-h>', '<C-\\><C-n><C-w>h', {noremap = true })
vim.keymap.set('t', '<C-j>', '<C-\\><C-n><C-w>j', {noremap = true })
vim.keymap.set('t', '<C-k>', '<C-\\><C-n><C-w>k', {noremap = true })
vim.keymap.set('t', '<C-l>', '<C-\\><C-n><C-w>l', {noremap = true })

