return {
  'L3MON4D3/LuaSnip',

  -- Do NOT reinstall or build again — LuaSnip is already installed as a dependency of cmp
  lazy = true, -- ensures we don’t override cmp's load behavior
  event = 'InsertEnter',

  dependencies = {
    'rafamadriz/friendly-snippets',
  },

  config = function()
    local ls = require 'luasnip'

    -- Core LuaSnip settings
    ls.config.set_config {
      history = true,
      updateevents = 'TextChanged,TextChangedI',
      enable_autosnippets = true,
    }

    -- Load VSCode snippets (from friendly-snippets)
    require('luasnip.loaders.from_vscode').lazy_load()

    -- Load custom Lua snippets
    require('luasnip.loaders.from_lua').lazy_load {
      paths = vim.fn.stdpath 'config' .. '/lua/custom/snippets',
    }
  end,
}
