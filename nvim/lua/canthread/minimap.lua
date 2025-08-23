
-- Toggle minimap
require('mini.map').setup({
  integrations = {
    require('mini.map').gen_integration.builtin_search(),
    require('mini.map').gen_integration.gitsigns(),
    require('mini.map').gen_integration.diagnostic(),
  },
  
  symbols = {
    encode = require('mini.map').gen_encode_symbols.dot('4x2'),
    scroll_line = '█',
    scroll_view = '┃',
  },
  
  window = {
    side = 'right',
    width = 20,
    winblend = 25,
    show_integration_count = true,
  },
})
--

