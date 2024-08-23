-- Previous Treesitter module - nvim-ts-rainbow

return {
  'HiPhish/rainbow-delimiters.nvim',

  config = function()
    local rainbow_delimiters = require 'rainbow-delimiters'
    local opts = {

      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      priority = {
        [''] = 110,
        lua = 210,
      },
      highlight = {
        'RainbowDelimiterRed',
        'RainbowDelimiterYellow',
        'RainbowDelimiterBlue',
        'RainbowDelimiterOrange',
        'RainbowDelimiterGreen',
        'RainbowDelimiterViolet',
        'RainbowDelimiterCyan',
      },
    }

    require('rainbow-delimiters.setup').setup(opts)
  end,
}
