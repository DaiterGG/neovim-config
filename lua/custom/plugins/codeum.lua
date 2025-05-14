return {
  'Exafunction/codeium.vim',
  config = function()
    vim.g.codeium_disable_bindings = 1
    --vim.g.codeium_manual = true
    -- Change '<C-g>' here to any keycode you like.
    vim.keymap.set('i', '<C-g>', function()
      return vim.fn['codeium#Accept']()
    end, { expr = true, silent = true })

    vim.keymap.set('n', '<Esc>', function()
      -- Call your custom function
      vim.fn['codeium#Clear']()
      -- Return default behavior for <C-c>
      return vim.api.nvim_replace_termcodes('<C-c>', true, true, true)
    end, { expr = true, silent = true })
    vim.keymap.set('n', '<C-c>', function()
      -- Call your custom function
      vim.fn['codeium#Clear']()
      -- Return default behavior for <C-c>
      return vim.api.nvim_replace_termcodes('<C-c>', true, true, true)
    end, { expr = true, silent = true })

    -- vim.keymap.set('i', '<C-m>', function()
    -- return vim.fn['codeium#CycleOrComplete']()
    -- return vim.fn['codeium#CycleCompletions'](1)
    -- end, { expr = false })

    vim.keymap.set('i', '<C-w>', function()
      return vim.fn['codeium#CycleCompletions'](-1)
    end, { expr = true, silent = true })
  end,
}
