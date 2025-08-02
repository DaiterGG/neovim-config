return {
  'numToStr/Comment.nvim',
  event = 'VeryLazy',
  -- config = function()
  --   -- local ft = require 'Comment.ft'

  --   --1. Using method signature
  --   -- Set only line comment or both
  --   -- You can also chain the set calls
  --   -- ft.set('yaml', '#%s').set('javascript', { '//%s', '/*%s*/' })

  --   -- 2. Metatable magic
  --   -- ft.javascript = { '//%s', '/*%s*/' }
  --   -- ft.yaml = '#%s'

  --   -- 3. Multiple filetypes
  --   -- ft({ 'test','conf', 'frag', 'shader', 'glsl', 'vert', 'txt' }, { '//%s', '/*%s*/' })
  --   -- ft({ 'toml', 'graphql' }, '#%s')
  -- end,
  opts = {
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = '^[%s]*$',
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
      ---Line-comment toggle keymap
      line = 'gcc',
      ---Block-comment toggle keymap
      block = 'gbc',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
      ---Line-comment keymap
      line = 'gc',
      ---Block-comment keymap
      block = 'gb',
    },
    ---LHS of extra mappings
    extra = {
      ---Add comment on the line above
      above = 'gcO',
      ---Add comment on the line below
      below = 'gco',
      ---Add comment at the end of line
      eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
      ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
      basic = true,
      ---Extra mapping; `gco`, `gcO`, `gcA`
      extra = true,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
  },
}
