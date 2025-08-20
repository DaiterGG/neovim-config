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
        --only for rs files
        if vim.api.nvim_buf_get_option(bufnr, 'filetype') == 'rs' then
          vim.cmd.RustLsp { 'hover', 'actions' }
        else
          vim.lsp.buf.hover()
        end
      end,
      { silent = true, buffer = bufnr }
    )

    vim.keymap.set('n', '<leader>ch', function()
      pcall(vim.cmd.RustLsp 'explainError')
    end, { silent = true, buffer = bufnr, desc = '[C]ode [H]elp with error [Rust]' })

    vim.keymap.set('n', '<leader>cj', function()
      pcall(vim.cmd.RustLsp 'relatedDiagnostics')
    end, { silent = true, buffer = bufnr, desc = '[C]ode [J]ump to related diagnostics [Rust]' })

    vim.keymap.set('n', '<leader>ci', function()
      pcall(vim.cmd.RustLsp 'openDocs')
    end, { silent = true, buffer = bufnr, desc = '[C]ode [I]nfo [Rust]' })

    vim.keymap.set('n', '<leader>cc', function()
      pcall(vim.cmd.RustLsp { 'renderDiagnostic', 'cycle' })
    end, { silent = true, buffer = bufnr, desc = '[C]ode [C]ycle diagnostics [Rust]' })

    vim.keymap.set('n', '<leader>cr', function()
      pcall(vim.cmd.RustLsp { 'renderDiagnostic' })
    end, { silent = true, buffer = bufnr, desc = '[R]ender current diagnostics [Rust]' })

    vim.keymap.set('n', '<leader>nq', ':w<cr>:tabnew<cr>:term<cr>ar<cr><C-\\><C-n>:q<cr>',
      { desc = 'rust run headless without terminal' })

    vim.keymap.set('n', '<leader>nc', function()
      OpenTermThen("cargo build<cr><C-\\><C-n>")
    end, { desc = 'rust [C]ompile' })
    vim.keymap.set('n', '<leader>nr', function()
      OpenTermThen('cargo run<cr><C-\\><C-n>')
    end, { desc = 'rust run' })
    vim.keymap.set('n', '<leader>nt', function()
      OpenTermThen('cargo test<cr><C-\\><C-n>')
    end, { desc = 'rust test' })
    vim.keymap.set('n', '<leader>nb', function()
      OpenTermThen('cargo bench<cr><C-\\><C-n>')
    end, { desc = 'rust bench' })
  end,
})
