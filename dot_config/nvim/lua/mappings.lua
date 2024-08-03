local wk_prefixes = require('utils.wk-prefixes')

-- Aliases
local cmap = function(...) vim.keymap.set('c', ...) end
local imap = function(...) vim.keymap.set('i', ...) end
local nmap = function(...) vim.keymap.set('n', ...) end
local tmap = function(...) vim.keymap.set('t', ...) end
local vmap = function(...) vim.keymap.set('v', ...) end
local map = vim.keymap.set

-- Set leader keys as <Space> and local leader as <Space>m
vim.g.mapleader = ' '
vim.g.maplocalleader = ' m'

nmap('j', 'gj')
nmap('k', 'gk')
vmap('j', 'gj')
vmap('k', 'gk')

nmap('<Esc>', vim.cmd.nohlsearch)

tmap('<Esc>', '<C-\\><C-n>') -- Exit insert mode in terminal mode
tmap('<C-\\><Esc>', '<Esc>', { desc = 'input esc' })

nmap('vgp', '`[v`]', { desc = 'select last pasted text (last edited text)' })
nmap(']p', ':put<Cr>`[V`]=', { desc = 'paste with right indentation' })

-- Erase last word with Ctrl + Backspace
map({ 'i', 'c', 't' }, '<C-BS>', '<C-w>')
map({ 'i', 'c', 't' }, '<C-h>', '<C-w>')

-- Currently being handled by better-escape.nvim
-- imap('jk', '<Esc>')

vmap('>', '>gv')
vmap('<', '<gv')

wk_prefixes.add('<leader>f', 'file')
nmap('<leader>fc', ':Telescope find_files cwd=~/.dotfiles/dot_config/nvim<Cr>', { desc = 'find file in config' })
nmap('<leader>fs', vim.cmd.write, { desc = 'save file' })

wk_prefixes.add('<leader>b', 'buffer')
nmap('<leader>bn', vim.cmd.bnext, { desc = 'goto next buffer' })
nmap('<leader>bp', vim.cmd.bprevious, { desc = 'goto previous buffer' })
nmap('<leader>bk', vim.cmd.bdelete, { desc = 'kill this buffer' })

wk_prefixes.add('<leader>w', '+window')
nmap('<leader>w', function() require('which-key').show { keys = '<C-w>', loop = true } end)

wk_prefixes.add('<leader>q', 'quit')
nmap('<leader>qq', vim.cmd.quitall, { desc = 'quit all' })

wk_prefixes.add('<leader><Tab>', 'tab')
nmap('<leader><Tab>c', vim.cmd.tabnew)
nmap('<leader><Tab>n', vim.cmd.tabnext)
nmap('<leader><Tab>p', vim.cmd.tabprevious)

wk_prefixes.add('<leader>c', 'code')
wk_prefixes.add('<leader>g', 'git')
wk_prefixes.add('<leader>t', 'toggle')
