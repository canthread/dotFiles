require("canthread")
print("Be Decisive!")

vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex) 

vim.keymap.set("n", "<leader>ww", function()
	vim.cmd("w!")
end)

vim.keymap.set("n", "<leader>qq",function()
	vim.cmd("q!")
end)

vim.keymap.set("n", "<leader><leader>",function()
	vim.cmd("so")
end)

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)


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


-- Change all line numbers to light brown
vim.api.nvim_set_hl(0, 'LineNr', { fg = '#d2b48c' })

-- Change current line number to cyan
vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#00ffff' })

-- Keep cursor centered with some padding
vim.opt.scrolloff = 50  -- Keeps 10 lines above/below cursor

-- Search keybindings (add this after your existing mappings)
vim.keymap.set('n', '<leader>s', '/', { desc = 'Search forward' })
vim.keymap.set('n', '<leader>S', '?', { desc = 'Search backward' })
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { noremap = true, silent = true, desc = 'Clear search highlights' })
vim.keymap.set('n', '<leader>sr', ':%s/', { desc = 'Search and replace globally' })
vim.keymap.set('v', '<leader>sr', ':s/', { desc = 'Search and replace in selection' })



