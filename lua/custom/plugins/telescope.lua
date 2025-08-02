if vim.g.vscode then
  return {
    'nvim-telescope/telescope.nvim',
  }
end
-- Fuzzy Finder (files, lsp, etc)
return {
  'nvim-telescope/telescope.nvim',
  event = 'VeryLazy',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- Useful for getting pretty icons, but requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons',            enabled = vim.g.have_nerd_font },
  },
  config = function()
    require('telescope').load_extension 'recent_files'
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        path_display = function(opts, path)
          local tail = require('telescope.utils').path_tail(path)

          -- Split the tail by the directory separator
          local parts = {}
          for part in string.gmatch(path, '[^\\]+') do
            table.insert(parts, part)
          end

          for part in string.gmatch(path, '[^/]+') do
            table.insert(parts, part)
          end
          if string.sub(parts[1], -1) == ':' then
            parts[1] = '[' .. string.upper(parts[1]) .. ']'
          end

          -- Reverse the parts
          local reversed_parts = {}
          for i = #parts, 1, -1 do
            table.insert(reversed_parts, parts[i])
          end
          table.remove(reversed_parts, 1)

          local flipped_path = table.concat(reversed_parts, '\\')

          return (tail .. '   \\' .. flipped_path)
        end,
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = { width = 0.999, height = 0.999, preview_width = 0.6 },
        },
        mappings = {
          i = {
            ['<C-h>'] = 'move_selection_next',
            ['<C-t>'] = 'move_selection_previous',
            ['<C-e>'] = 'preview_scrolling_up',
            ['<C-u>'] = 'preview_scrolling_down',
          },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
          ['recent_files'] = {
            only_cwd = true,
            transform_file_path = function(path)
              -- return vim.fn.fnamemodify(path, ':t')
              error 'not working'
              return ''
            end,
          },
        },
      },
    }
    -- Enable Telescope extensions if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>sb', builtin.buffers, { desc = '[S]earch existing [B]uffers' })

    -- NOTE: oldfiles is bad, I use smartpde/telescope-recent-files
    -- vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

    opts = { noremap = true, silent = true }

    -- Map a shortcut to open the picker.
    -- vim.api.nvim_set_keymap('n', '<Leader><Leader>', [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]], { desc = 'Recent Files' })
    vim.api.nvim_set_keymap('n', '<Leader>h', [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
      { desc = 'Recent Files' })

    -- select current directory
    vim.keymap.set('n', '<leader>sc', function()
      vim.cmd 'cd %:h'
      vim.cmd 'cd'
    end, { desc = '[S]elect [C]urrent directory' })

    vim.keymap.set('n', '<leader>b', function()
      vim.cmd 'cd ..'
      vim.cmd 'cd'
    end, { desc = 'Go [B]ack' })

    -- select C:/ directory
    vim.keymap.set('n', '<leader>sC', function()
      vim.cmd 'cd C:/'
      vim.cmd 'cd'
    end, { desc = '[S]elect [C]:/ directory' })

    -- select D:/ directory
    vim.keymap.set('n', '<leader>sD', function()
      vim.cmd 'cd D:/'
      vim.cmd 'cd'
    end, { desc = '[S]elect [D]:/ directory' })

    -- overriding default behavior and theme
    vim.keymap.set(
      'n',
      '<leader>/',
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find,
      { desc = '[/] Fuzzily search in current buffer' }
    )

    local c_c = vim.api.nvim_replace_termcodes('<C-c>', true, true, true)
    -- recent files window
    vim.keymap.set('i', '<esc>', function()
      vim.api.nvim_feedkeys(c_c, 'm', false)
      local tl = require 'telescope'
      if tl.active then
        tl.actions.close()
      end
    end, opts)

    vim.keymap.set(
      'v',
      '<leader>/',
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      'y<leader>/<C-r>">',
      { remap = true, desc = '[/] Fuzzily search in current buffer' }
    )

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[S]earch [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files' })

    vim.keymap.set('n', '<leader>cs', function()
      builtin.colorscheme { enable_preview = true }
    end, { desc = '[C]olor [S]cheme' })
  end,
}
