if vim.g.vscode then
  return {}
end
-- Highlight connected via blank lines code blocks
return {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  event = 'VeryLazy',
  opts = {

    scope = {
      enabled = true,
      show_exact_scope = true,
      include = {
        node_type = { lua = { 'return_statement', 'table_constructor' } },
      },
    },
  },
  config = function(_, opts)
    local highlight = {
      "RainbowRed",
      "RainbowYellow",
      "RainbowBlue",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowViolet",
      "RainbowCyan",
    }

    local hooks = require "ibl.hooks"
    -- create the highlight groups in the highlight setup hook, so they are reset
    -- every time the colorscheme changes
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#203019" })
      vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#37412d" })
      vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#203019" })
      vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#37412d" })
      vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#203019" })
      vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#37412d" })
      vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#203019" })
      vim.api.nvim_set_hl(0, 'IblScope', { fg = '#446436' })
    end)

    opts.indent = { highlight = highlight }
    require('ibl').setup(opts)
  end
}
