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
    vim.keymap.set('n', '<leader>nq', ':w<cr>:tabnew<cr>:term<cr>ar<cr><C-\\><C-n>:q<cr>', { desc = 'rust run headless without terminal' })

    local open_if_not = '<C-\\><C-n><C-w>h<C-w>o:w<cr>:ToggleTerm<cr>a<cr>'
    vim.keymap.set('n', '<leader>nc', open_if_not .. 'cargo build<cr><C-\\><C-n>', { desc = 'rust compile' })
    vim.keymap.set('n', '<leader>nr', open_if_not .. 'cargo run<cr><C-\\><C-n>', { desc = 'rust run' })
    vim.keymap.set('n', '<leader>nt', open_if_not .. 'cargo test<cr><C-\\><C-n>', { desc = 'rust test' })
    vim.keymap.set('n', '<leader>nb', open_if_not .. 'cargo bench<cr><C-\\><C-n>', { desc = 'rust bench' })
  end,
})
