-- autocomplete for / cmdline
return {
  'hrsh7th/cmp-cmdline',
  opts = {},
  config = function()
    -- `:` cmdline setup.
    local cmp = require 'cmp'
    cmp.setup.cmdline(':', {
      -- mapping = cmp.mapping.preset.cmdline {
      --   ['<C-n>'] = cmp.mapping.confirm { select = true },
      -- },
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        {
          name = 'cmdline',
          option = {},
        },
      }),
    })
    cmp.setup.cmdline('?', {
      mapping = cmp.mapping.preset.cmdline {},
      sources = {
        { name = 'buffer' },
      },
    })
    cmp.setup.cmdline('/', {
      mapping = cmp.mapping.preset.cmdline {},
      sources = {
        { name = 'buffer' },
      },
    })
  end,
}
