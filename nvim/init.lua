require("michaeltorkaman")
print("Sticky Hands dont type fast!")

vim.opt.clipboard:append("unnamedplus")

vim.wo.number = true
vim.wo.relativenumber = true
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting

-- Comprehensive Copilot keybindings
local opts = { noremap = true, silent = true }

-- Basic controls
vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', vim.tbl_extend('force', opts, { desc = 'Enable Copilot' }))
vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', vim.tbl_extend('force', opts, { desc = 'Disable Copilot' }))
vim.keymap.set('n', '<leader>ct', ':Copilot toggle<CR>', vim.tbl_extend('force', opts, { desc = 'Toggle Copilot' }))
vim.keymap.set('n', '<leader>cs', ':Copilot status<CR>', vim.tbl_extend('force', opts, { desc = 'Copilot Status' }))

vim.keymap.set('n', '<leader>cp', ':Copilot panel<CR>', vim.tbl_extend('force', opts, { desc = 'Copilot Panel' }))

-- Suggestion controls in insert mode
vim.keymap.set('i', '<C-j>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
vim.keymap.set('i', '<C-l>', '<Plug>(copilot-accept-word)')
vim.keymap.set('i', '<C-h>', '<Plug>(copilot-dismiss)')
vim.keymap.set('i', '<C-n>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-p>', '<Plug>(copilot-previous)')

