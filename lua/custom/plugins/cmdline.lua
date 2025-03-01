-- autocomplete for / cmdline
return {
  'hrsh7th/cmp-cmdline',
  opts = {},
  config = function()
    -- `:` cmdline setup.
    local cmp = require 'cmp'
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline {

        ['<C-h>'] = cmp.mapping.select_next_item(),
        -- Select the [p]revious item
        ['<C-t>'] = cmp.mapping.select_prev_item(),

        --  This will auto-import if your LSP supports it.
        --  This will expand snippets if the LSP sent a snippet.
        ['<C-n>'] = cmp.mapping.confirm { select = true },
      },
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
