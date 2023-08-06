-- Aliases
local nmap = function(...) vim.keymap.set('n', ...) end
local imap = function(...) vim.keymap.set('i', ...) end
local vmap = function(...) vim.keymap.set('v', ...) end

-- Set leader keys as <Space> and local leader as <Space>m
vim.g.mapleader = ' '
vim.g.maplocalleader = ' m'

nmap('j', 'gj')
nmap('k', 'gk')

nmap('<C-s>', vim.cmd.write)

nmap('gp', '`[v`]')  -- select last pasted text (last edited text)
nmap(']p', ':put<Cr>`[V`]=')  -- paste with right indentation

imap('<C-BS>', '<C-w>')
imap('<C-h>', '<C-w>')

vmap('>', '>gv')
vmap('<', '<gv')

