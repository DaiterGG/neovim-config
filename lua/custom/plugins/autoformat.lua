return { -- Autoformat
  'stevearc/conform.nvim',
  event = 'BufReadPost',
  config = function()
    -- toggle autoformat
    local FormatOnSaveIsOn = true
    local desc = '[T]oggle [F]ormat On Save'
    ToggleFormatF = function()
      vim.keymap.set('n', '<leader>tf', function()
        FormatOnSaveIsOn = not FormatOnSaveIsOn
        ToggleFormatF()
      end, { noremap = true, silent = true, desc = (FormatOnSaveIsOn and '[ON] ' or '[OFF] ') .. desc })
    end
    ToggleFormatF()

    -- Manual formatting
    vim.keymap.set('n', '<leader>f', function()
      require('conform').format { async = true, lsp_format = 'fallback' }
    end, { noremap = true, silent = true, desc = '[F]ormat Document' })
    --Auto formatting
    vim.api.nvim_create_autocmd('BufWritePre', {
      callback = function()
        if FormatOnSaveIsOn then
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
