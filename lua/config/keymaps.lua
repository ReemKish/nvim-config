local keymap = function(mode, lhs, rhs, opts)
  opts = opts or { noremap = true, silent=true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Set leader to space.
keymap("n", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better window navigation, with tmux interoperation.
keymap("n", "<C-h>", ":NavigatorLeft<CR>")
keymap("n", "<C-j>", ":NavigatorDown<CR>")
keymap("n", "<C-k>", ":NavigatorUp<CR>")
keymap("n", "<C-l>", ":NavigatorRight<CR>")
keymap("n", "<C-tab>", ":NavigatorPrevious<CR>")

-- Traditional editor keymaps.
keymap({"n", "i"}, "<C-s>", "<ESC>:confirm w<CR>")  -- save
keymap({"n", "i"}, "<C-q>", "<ESC>:confirm q<CR>")  -- quit

-- Show pattern matches in the middle of the screen.
keymap("n", "n", "nzz")
keymap("n", "N", "Nzz")
keymap("n", "*", "*zz")
keymap("n", "#", "#zz")
keymap("n", "g*", "g*zz")
keymap("n", "g#", "g#zz")

-- Stay in visual mode when readjusting indentation.
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- jk to exit insert mode
keymap("i", "jk", "<ESC>", {})

-- Don't override the yank register when pasting over selected text.
keymap("x", "p", [["_dP]])

-- Mouse right-click menu
vim.cmd [[:amenu 10.100 mousemenu.Goto\ Definition <cmd>lua vim.lsp.buf.definition()<CR>]]
vim.cmd [[:amenu 10.110 mousemenu.References <cmd>lua vim.lsp.buf.references()<CR>]]
vim.keymap.set("n", "<RightMouse>", "<cmd>:popup mousemenu<CR>")
vim.keymap.set("n", "<Tab>", "<cmd>:popup mousemenu<CR>")

-- Use H and L to go to start of/end of line.
keymap({ "n", "o", "x" }, "<s-h>", "^")
keymap({ "n", "o", "x" }, "<s-l>", "g_")

vim.api.nvim_set_keymap('t', '<C-;>', '<C-\\><C-n>', {noremap = true, silent=true})
