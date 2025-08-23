-- File: ~/.config/nvim/after/plugin/copilot.lua
-- Complete optimized Copilot keybindings

local opts = { noremap = true, silent = true }

-- Basic Copilot controls
vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', vim.tbl_extend('force', opts, { desc = 'Enable Copilot' }))
vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', vim.tbl_extend('force', opts, { desc = 'Disable Copilot' }))
vim.keymap.set('n', '<leader>ct', ':Copilot toggle<CR>', vim.tbl_extend('force', opts, { desc = 'Toggle Copilot' }))
vim.keymap.set('n', '<leader>cs', ':Copilot status<CR>', vim.tbl_extend('force', opts, { desc = 'Copilot Status' }))
vim.keymap.set('n', '<leader>cp', ':Copilot panel<CR>', vim.tbl_extend('force', opts, { desc = 'Copilot Panel' }))

-- Suggestion controls in insert mode
vim.keymap.set('i', '<C-l>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
vim.keymap.set('i', '<C-k>', '<Plug>(copilot-accept-word)')
-- Replace <C-h> with <C-x> or another key
vim.keymap.set('i', '<C-x>', '<Plug>(copilot-dismiss)', { desc = 'Dismiss Copilot' })
vim.keymap.set('i', '<C-n>', '<Plug>(copilot-next)')
vim.keymap.set('i', '<C-p>', '<Plug>(copilot-previous)')



-- Safe wrapper for CopilotChat commands
local function safe_copilot_chat(command)
  return function()
    if pcall(require, 'CopilotChat') then
      vim.cmd(command)
    else
      print("CopilotChat not loaded yet")
    end
  end
end

-- FAST chat functions - since toggle/close are slow, just use fast open
-- Main chat keybindings (FAST versions)
vim.keymap.set('n', '<leader>cc', safe_copilot_chat('CopilotChatOpen'), vim.tbl_extend('force', opts, { desc = 'Chat Open (Fast)' }))
-- Fast window close alternative (since CopilotChatClose is slow)
local function fast_chat_close()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local buf_name = vim.api.nvim_buf_get_name(buf)
    if buf_name:match("copilot%-chat") or vim.bo[buf].filetype == "copilot-chat" then
      vim.api.nvim_win_close(win, false)
      break
    end
  end
end

vim.keymap.set('n', '<leader>co', safe_copilot_chat('CopilotChatOpen'), vim.tbl_extend('force', opts, { desc = 'Chat Open' }))
vim.keymap.set('n', '<leader>cx', fast_chat_close, vim.tbl_extend('force', opts, { desc = 'Chat Close (Fast)' }))

-- Visual mode functions (work best with code selections)
vim.keymap.set('v', '<leader>ce', safe_copilot_chat('CopilotChatExplain'), vim.tbl_extend('force', opts, { desc = 'Explain Code' }))
vim.keymap.set('v', '<leader>cr', safe_copilot_chat('CopilotChatReview'), vim.tbl_extend('force', opts, { desc = 'Review Code' }))
vim.keymap.set('v', '<leader>cf', safe_copilot_chat('CopilotChatFix'), vim.tbl_extend('force', opts, { desc = 'Fix Code' }))

-- Optional: Quick access to common chat prompts in normal mode
vim.keymap.set('n', '<leader>cq', safe_copilot_chat('CopilotChat'), vim.tbl_extend('force', opts, { desc = 'Quick Chat' }))
-- Note: Removed duplicate <leader>cr mapping (was conflicting with Review above)

-- Add this keybinding to your config:
vim.keymap.set('n', '<leader>crs', safe_copilot_chat('CopilotChatReset'), vim.tbl_extend('force', opts, { desc = 'Reset Chat (New Session)' }))
-- Add these to create multiple chat instances:
vim.keymap.set('n', '<leader>cc1', safe_copilot_chat('CopilotChatOpen'), vim.tbl_extend('force', opts, { desc = 'Chat Window 1' }))
vim.keymap.set('n', '<leader>cc2', safe_copilot_chat('CopilotChatOpen'), vim.tbl_extend('force', opts, { desc = 'Chat Window 2' }))
vim.keymap.set('n', '<leader>cc3', safe_copilot_chat('CopilotChatOpen'), vim.tbl_extend('force', opts, { desc = 'Chat Window 3' }))

-- Open chat and automatically include selection as context
vim.keymap.set('v', '<leader>ca', function()
  require('CopilotChat').open({
    selection = require('CopilotChat.select').visual
  })
end, vim.tbl_extend('force', opts, { desc = 'Ask About Selection' }))
