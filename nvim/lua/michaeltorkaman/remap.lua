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


