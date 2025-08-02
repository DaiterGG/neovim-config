return {
  'uga-rosa/ccc.nvim',
  event = 'VeryLazy',
  config = function()
    local ccc     = require('ccc')
    local mapping = ccc.mapping

    -- setup ccc with custom mappings
    ccc.setup({

      pickers = {
        ccc.picker.hex,
        ccc.picker.css_rgb,
        ccc.picker.css_hsl,
        ccc.picker.css_hwb,
        ccc.picker.css_lab,
        ccc.picker.css_lch,
        ccc.picker.css_oklab,
        ccc.picker.css_oklch,
      },
      highlighter = {
        auto_enable = true,
        lsp         = true,
      },
      mappings = {
        p = mapping.toggle_prev_colors,
        h = mapping.none,
        u = mapping.increase1,
        e = mapping.decrease1,
        U = mapping.increase10,
        E = mapping.decrease10,
      },
    })

    -- editor keymaps
    vim.keymap.set('n', '<leader>cp', '<cmd>CccPick<cr>', { desc = '[C]olor [P]icker' })
    vim.keymap.set('n', '<leader>cc', '<cmd>CccConvert<cr>', { desc = '[C]olor [C]onvert' })
    vim.keymap.set('n', '<leader>tc', '<cmd>CccHighlighterToggle<cr>', { desc = '[T]oggle [C]olor Highlight' })
  end,
}
