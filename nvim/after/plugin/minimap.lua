-- Toggle minimap
vim.keymap.set('n', '<leader>mm', require('mini.map').toggle, { desc = 'Toggle minimap' })

-- Open minimap
vim.keymap.set('n', '<leader>mo', require('mini.map').open, { desc = 'Open minimap' })

-- Close minimap
vim.keymap.set('n', '<leader>mc', require('mini.map').close, { desc = 'Close minimap' })

-- Refresh minimap
vim.keymap.set('n', '<leader>mr', require('mini.map').refresh, { desc = 'Refresh minimap' })
