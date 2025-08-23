-- Store the last position before going to definition
local last_gd_position = nil

-- Function to save current position
local function save_position()
  local buf = vim.api.nvim_get_current_buf()
  local pos = vim.api.nvim_win_get_cursor(0)
  last_gd_position = { buf = buf, pos = pos }
end

-- Function to go back to last gd position
local function go_back_to_last_gd()
  if last_gd_position then
    -- Switch to the buffer
    vim.api.nvim_set_current_buf(last_gd_position.buf)
    -- Set cursor position
    vim.api.nvim_win_set_cursor(0, last_gd_position.pos)
    print("Returned to last gd position")
  else
    print("No previous gd position saved")
  end
end

-- Function to set window theme/appearance
local function set_new_window_theme()
  -- Get the current window ID
  local win_id = vim.api.nvim_get_current_win()
  
  -- Set window-specific options with emerald green background
  vim.api.nvim_win_set_option(win_id, 'winhighlight', 
    'Normal:EmeraldNormal,SignColumn:EmeraldSignColumn,LineNr:EmeraldLineNr,CursorLine:EmeraldCursorLine')

      -- Define the darker emerald highlight groups
  vim.api.nvim_set_hl(0, 'EmeraldNormal', { bg = '#022c22', fg = '#f8f8f2' })  -- very dark emerald bg
  vim.api.nvim_set_hl(0, 'EmeraldSignColumn', { bg = '#022c22' })
  vim.api.nvim_set_hl(0, 'EmeraldLineNr', { bg = '#022c22', fg = '#75715e' })
  vim.api.nvim_set_hl(0, 'EmeraldCursorLine', { bg = '#064e3b' })
  
  
  -- Set window-local options for additional visual distinction
  vim.wo.number = true
  vim.wo.relativenumber = true
  vim.wo.cursorline = true
  vim.wo.signcolumn = 'yes'
end

-- Main go to definition function
local function smart_go_to_definition()
  local current_buf = vim.api.nvim_get_current_buf()
  local current_file = vim.api.nvim_buf_get_name(current_buf)
  
  -- Save current position before going to definition
  save_position()
  
  -- Get definition location
  local params = vim.lsp.util.make_position_params()
  
  vim.lsp.buf_request(current_buf, 'textDocument/definition', params, function(err, result, ctx, config)
    if err then
      print("Error getting definition: " .. err.message)
      return
    end
    
    if not result or vim.tbl_isempty(result) then
      print("No definition found")
      return
    end
    
    -- Handle both single result and array of results
    local definition = result[1] or result
    local target_uri = definition.uri or definition.targetUri
    local target_file = vim.uri_to_fname(target_uri)
    
    -- Check if definition is in the same file
    if target_file == current_file then
      -- Same file - just go to definition normally
      vim.lsp.buf.definition()
      print("Definition in same file")
    else
      -- Different file - prompt for split direction
      print("Definition in different file. Press 'v' for vertical split, 'h' for horizontal split:")
      
      local char = vim.fn.getchar()
      local key = vim.fn.nr2char(char)
      
      if key == 'v' then
        -- Vertical split: new window on the right, old window on the left
        vim.cmd('rightbelow vsplit')
        vim.lsp.buf.definition()
        set_new_window_theme()
        print("Opened definition in vertical split (right side)")
      elseif key == 'h' then
        -- Horizontal split: new window on top, old window below
        vim.cmd('aboveleft split')
        vim.lsp.buf.definition()
        set_new_window_theme()
        print("Opened definition in horizontal split (top)")
      else
        print("Invalid choice. Cancelling.")
      end
    end
  end)
end

-- Function to switch between windows
local function switch_windows()
  vim.cmd('wincmd w')  -- Switch to next window
end

-- Set up keymaps
vim.keymap.set('n', '<leader>gd', smart_go_to_definition, { desc = 'Smart go to definition' })
vim.keymap.set('n', '<leader>bb', go_back_to_last_gd, { desc = 'Go back to last gd position' })

-- Window switching keymaps
vim.keymap.set('n', '<leader>w', switch_windows, { desc = 'Switch between windows' })
vim.keymap.set('n', '<C-w>w', switch_windows, { desc = 'Switch between windows' })

-- Additional window navigation keymaps
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
