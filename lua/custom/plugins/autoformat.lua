return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  config = function()
    --Auto formatting
    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function()
        local toggle_format = true
        -- toggle autoformat
        vim.keymap.set('n', '<leader>tf', function()
          toggle_format = not toggle_format
        end, { noremap = true, silent = true, desc = '[T]oggle [F]ormat On Save' })

        -- Manual formating
        vim.keymap.set('n', '<leader>f', function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end, { noremap = true, silent = true, desc = '[F]ormat Document' })
        if toggle_format then
          require('conform').format { async = false, lsp_format = 'fallback' }
        end
      end,
    })
  end,
  cmd = { 'ConformInfo' },
  -- keys = {
  --   {
  --     '<leader>f',
  --     function()
  --       require('conform').format { async = true, lsp_format = 'fallback' }
  --     end,
  --     mode = '',
  --     desc = '[F]ormat buffer',
  --   },
  -- },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      -- local disable_filetypes = { c = true, cpp = true }
      -- local lsp_format_opt
      -- if disable_filetypes[vim.bo[bufnr].filetype] then
      --   lsp_format_opt = 'never'
      -- else
      --   lsp_format_opt = 'fallback'
      -- end
      -- return {
      --   timeout_ms = 55500,
      --   lsp_format = lsp_format_opt,
      -- }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { 'prettierd', 'prettier', stop_after_first = false },
    },
  },
}
