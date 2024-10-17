-- Show line after desired maximum text width
vim.cmd([[setlocal textwidth=89]])
vim.cmd([[setlocal colorcolumn=+1]])

-- Indentation
vim.g.pyindent_open_paren = 'shiftwidth()'
vim.g.pyindent_continue = 'shiftwidth()'

-- mini.indentscope
vim.b.miniindentscope_config = { options = { border = 'top' } }
