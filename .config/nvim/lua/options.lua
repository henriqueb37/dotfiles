local g = vim.g
local o = vim.o
local bo = vim.bo
local wo = vim.wo

o.clipboard = 'unnamedplus'

o.number = true
o.relativenumber = true
o.signcolumn = "yes"
o.conceallevel = 2
o.fillchars = "eob: "
o.cursorline = true

o.laststatus = 3

o.shiftwidth = 2
o.tabstop = 2
o.softtabstop = 2
o.expandtab = true
o.smartindent = true

o.wrap = false

o.hlsearch = true
o.incsearch = true
o.ignorecase = true

o.termguicolors = true
o.guifont = 'JetBrainsMono Nerd Font:h11'

o.scrolloff = 8
o.sidescrolloff = 8

o.completeopt = 'menuone,noselect,noinsert,preview'

o.splitright = true
o.splitbelow = true

g.neovide_padding_left = 10
g.neovide_padding_down = 10
g.neovide_padding_top = 10
g.neovide_padding_right = 10
g.neovide_cursor_vfx_mode = "wireframe"
g.neovide_transparency = 0.9

-- Filetype specifc config

-- vim.api.nvim_create_augroup("c-options", { clear = true })
-- vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
--   pattern = { "*.h", "*.c" },
--   group = "c-options",
--   callback = function()
--     bo.tabstop = 4
--     bo.shiftwidth = 4
--   end,
-- })

vim.api.nvim_create_augroup("mcfunction-options", { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { "*.mcfunction" },
  group = "mcfunction-options",
  callback = function()
    wo.wrap = true
    wo.linebreak = true
    wo.breakindent = true
    wo.breakindentopt = "shift:4"
  end,
})

vim.api.nvim_create_augroup("markdown-options", { clear = true })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { "*.md", "*.markdown" },
  group = "markdown-options",
  callback = function()
    wo.wrap = true
    wo.linebreak = true
    wo.breakindent = true
  end,
})
