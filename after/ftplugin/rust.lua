vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('kickstart-lsp-attach_rust', { clear = true }),
  callback = function(event)
    local bufnr = vim.api.nvim_get_current_buf()
    -- vim.keymap.set('n', '<leader>ca', function()
    --   -- vim.cmd.RustLsp 'codeAction' -- supports rust-analyzer's grouping
    --   -- or vim.lsp.buf.codeAction() if you don't want grouping.
    --   vim.lsp.buf.code_action()
    -- end, { remap = true, silent = true, buffer = bufnr })
    vim.keymap.set(
      'n',
      'K', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
      function()
        vim.cmd.RustLsp { 'hover', 'actions' }
      end,
      { silent = true, buffer = bufnr }
    )

    vim.keymap.set('n', '<leader>cde', function()
      vim.cmd.RustLsp 'explainError'
    end, { silent = true, buffer = bufnr, desc = '[C]ode [D]etailed [E]xplanation [Rust]' })

    vim.keymap.set('n', '<leader>cj', function()
      vim.cmd.RustLsp 'relatedDiagnostics'
    end, { silent = true, buffer = bufnr, desc = '[C]ode [J]ump to related diagnostics [Rust]' })

    vim.keymap.set('n', '<leader>cdc', function()
      vim.cmd.RustLsp 'openDocs'
    end, { silent = true, buffer = bufnr, desc = '[C]ode [D]o[C]umentation [Rust]' })

    vim.keymap.set('n', '<leader>cc', function()
      vim.cmd.RustLsp { 'renderDiagnostic', 'cycle' }
    end, { silent = true, buffer = bufnr, desc = '[C]ycle diagnostics [Rust]' })

    vim.keymap.set('n', '<leader>cr', function()
      vim.cmd.RustLsp { 'renderDiagnostic' }
    end, { silent = true, buffer = bufnr, desc = '[R]ender current diagnostics [Rust]' })
    vim.keymap.set('n', '<leader>nq', ':w<cr>:tabnew<cr>:term<cr>ar<cr><C-\\><C-n>:q<cr>', { desc = 'run quick board without terminal' })
    vim.keymap.set(
      'n',
      '<leader>nc',
      '<C-\\><C-n>:ToggleTerm<cr><C-w>h<C-w>o:w<cr>:ToggleTerm<cr>a<cr>a<cr>cargo build<cr><C-\\><C-n>',
      { desc = 'compile quick board' }
    )
    vim.keymap.set(
      'n',
      '<leader>nr',
      '<C-\\><C-n>:ToggleTerm<cr><C-w>h<C-w>o:w<cr>:ToggleTerm<cr>a<cr>a<cr>cargo run<cr><C-\\><C-n>',
      { desc = 'run quick board' }
    )
    vim.keymap.set(
      'n',
      '<leader>nt',
      '<C-\\><C-n>:ToggleTerm<cr><C-w>h<C-w>o:w<cr>:ToggleTerm<cr>a<cr>a<cr>cargo test<cr><C-\\><C-n>',
      { desc = 'test quick board' }
    )
    vim.keymap.set(
      'n',
      '<leader>nb',
      '<C-\\><C-n>:ToggleTerm<cr><C-w>h<C-w>o:w<cr>:ToggleTerm<cr>a<cr>a<cr>cargo bench<cr><C-\\><C-n>',
      { desc = 'bench quick board' }
    )
  end,
})
