local ls = require 'luasnip'

local s = ls.snippet

local f = ls.function_node

local function datetime(format)
  return os.date(format)
end

ls.add_snippets('sql', {
  s(
    'dtt',
    f(function()
      return datetime '%Y%m%d%H%M%S'
    end)
  ),
})
