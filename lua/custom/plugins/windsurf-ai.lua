return {
  'Exafunction/windsurf.nvim',
  -- dependencies = {
  --   'nvim-lua/plenary.nvim',
  --   'hrsh7th/nvim-cmp',
  -- },
  event = 'InsertEnter',
  config = function()
    vim.api.nvim_set_hl(0, 'CodeiumSuggestion', { undercurl = false, fg = '#5f875f' })
    require('codeium').setup {
      enable_cmp_source = false,
      virtual_text = {
        enabled = true,

        -- These are the defaults

        -- Set to true if you never want completions to be shown automatically.
        manual = false,
        -- A mapping of filetype to true or false, to enable virtual text.
        filetypes = {},
        -- Whether to enable virtual text of not for filetypes not specifically listed above.
        default_filetype_enabled = true,
        -- How long to wait (in ms) before requesting completions after typing stops.
        idle_delay = 1,
        -- Priority of the virtual text. This usually ensures that the completions appear on top of
        -- other plugins that also add virtual text, such as LSP inlay hints, but can be modified if
        -- desired.
        virtual_text_priority = 65535,
        -- Set to false to disable all key bindings for managing completions.
        map_keys = true,
        -- The key to press when hitting the accept keybinding but no completion is showing.
        -- Defaults to \t normally or <c-n> when a popup is showing.
        accept_fallback = '',
        -- Key bindings for managing completions in virtual text mode.
        key_bindings = {
          -- Accept the current completion.
          accept = '<C-g>',
          -- Accept the next word.
          accept_word = false,
          -- Accept the next line.
          accept_line = false,
          -- Clear the virtual text.
          clear = false,
          -- Cycle to the next completion.
          next = '<c-w>',
          -- Cycle to the previous completion.
        },
      },
    }

    WindIsOn = false
    vim.cmd 'silent Codeium Toggle'

    vim.keymap.set('n', '<leader>tw', function()
      WindIsOn = not WindIsOn
      vim.cmd 'Codeium Toggle'
    end
    , { silent = false, desc = '[T]oggle [W]indsurf' })
  end,
}


-- NOTE: codeium old config
-- return {
--   'Exafunction/codeium.vim',
--   config = function()
--     vim.g.codeium_disable_bindings = 1
--     --vim.g.codeium_manual = true
--     -- Change '<C-g>' here to any keycode you like.
--     vim.keymap.set('i', '<C-g>', function()
--       return vim.fn['codeium#Accept']()
--     end, { expr = true, silent = true })

--     vim.keymap.set('n', '<Esc>', function()
--       -- Call your custom function
--       vim.fn['codeium#Clear']()
--       -- Return default behavior for <C-c>
--       return vim.api.nvim_replace_termcodes('<C-c>', true, true, true)
--     end, { expr = true, silent = true })
--     vim.keymap.set('n', '<C-c>', function()
--       -- Call your custom function
--       vim.fn['codeium#Clear']()
--       -- Return default behavior for <C-c>
--       return vim.api.nvim_replace_termcodes('<C-c>', true, true, true)
--     end, { expr = true, silent = true })

--     vim.keymap.set('n', '<leader>tc', ':CodeiumToggle<cr>', { silent = true, desc = '[T]oggle [C]odeium' })
--     -- vim.keymap.set('i', '<C-m>', function()
--     -- return vim.fn['codeium#CycleOrComplete']()
--     -- return vim.fn['codeium#CycleCompletions'](1)
--     -- end, { expr = false })

--     vim.keymap.set('i', '<C-w>', function()
--       return vim.fn['codeium#CycleCompletions'](-1)
--     end, { expr = true, silent = true })
--   end,
-- }
