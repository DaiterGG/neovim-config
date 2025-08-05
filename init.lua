require('modules.server_rpc')

-- neovim-tree requires this
--
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.swapfile = false

-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.opt.expandtab = true
-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true
-- [[ setting options ]]
-- see `:help vim.opt`
-- note: you can change these options as you wish!
--  for more options, you can see `:help option-list`
vim.g.undotree_DiffCommand = 'FC'

vim.opt.equalalways = false
vim.g.equalalways = false

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
vim.opt.relativenumber = false

vim.opt.showtabline = 0

vim.api.nvim_create_autocmd('UIEnter', {
  callback = function()
    vim.cmd 'set formatoptions-=r'
    vim.cmd 'set formatoptions-=c'
    vim.cmd 'set formatoptions-=o'
  end,
})
-- Enable break indent
vim.opt.breakindent = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = {}

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamed'
end)
local vkopt = { noremap = true, silent = true }
local vk = vim.keymap

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- TIP: Disable arrow keys in normal mode
-- vk.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vk.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vk.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vk.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- require('nvim-treesitter.install').compilers = { 'clang', 'zig' }
-- require('nvim-treesitter.install').compilers = { 'cc', 'gcc', 'cl', 'zig' }
-- require('nvim-treesitter.install').prefer_git = false

vim.g.editorconfig = false

vim.opt.guicursor = 'n-v-c:block,i:ver10'
-- vim.opt.guicursor = 'n-v-c:hor10,i:ver10'

vim.g.autoformat = false
vim.o.titlestring = [[%t – %F]]
vim.o.title = true


-- Define highlight groups
vim.diagnostic.config { virtual_text = true }

--sqlite hookup
--required by smart open
vim.g.sqlite_clib_path = 'c:/sqlite/sqlite3.dll'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'xero/miasma.nvim',
    event = 'BufEnter',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'miasma'
    end,
  },
  -- NOTE: Disabled for now (bad detections)
  --'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- {
  --   'tris203/rzls.nvim',
  --   -- opts = {
  --   --   -- on_attach = function() end,
  --   --   -- capabilities = capabilities,
  --   -- },
  -- },

  -- {
  --   'seblj/roslyn.nvim',
  --   ft = { 'cs' },
  --   opts = {
  --     args = {
  --       '--logLevel=Information',
  --       '--extensionLogDirectory=' .. vim.fs.dirname(vim.lsp.get_log_path()),
  --       '--razorSourceGenerator='
  --         .. vim.fs.joinpath(vim.fn.stdpath 'data' --[[@as string]], 'mason', 'packages', 'roslyn', 'libexec', 'Microsoft.CodeAnalysis.Razor.Compiler.dll'),
  --       '--razorDesignTimePath=' .. vim.fs.joinpath(
  --         vim.fn.stdpath 'data' --[[@as string]],
  --         'mason',
  --         'packages',
  --         'rzls',
  --         'libexec',
  --         'Targets',
  --         'Microsoft.NET.Sdk.Razor.DesignTime.targets'
  --       ),
  --     },
  --     config = {
  --       -- handlers = require 'rzls.roslyn_handlers',
  --     },
  --     filewatching = true,
  --     additional_vim_regex_highlighting = true,
  --     dotnet_provide_regex_completion = true,
  --     on_attach = function(client, bufnr)
  --       -- NOTE: Super hacky... Don't know if I like that we set a random variable on the client
  --       -- Seems to work though
  --       if client.is_hacked then
  --         return
  --       end
  --       client.is_hacked = true

  --       -- let the runtime know the server can do semanticTokens/full now
  --       client.server_capabilities = vim.tbl_deep_extend('force', client.server_capabilities, {
  --         semanticTokensProvider = {
  --           full = true,
  --         },
  --       })

  --       -- monkey patch the request proxy
  --       local request_inner = client.request
  --       client.request = function(method, params, handler, req_bufnr)
  --         if method ~= vim.lsp.protocol.Methods.textDocument_semanticTokens_full then
  --           return request_inner(method, params, handler)
  --         end

  --         local target_bufnr = vim.uri_to_bufnr(params.textDocument.uri)
  --         local line_count = vim.api.nvim_buf_line_count(target_bufnr)
  --         local last_line = vim.api.nvim_buf_get_lines(target_bufnr, line_count - 1, line_count, true)[1]

  --         return request_inner('textDocument/semanticTokens/range', {
  --           textDocument = params.textDocument,
  --           range = {
  --             ['start'] = {
  --               line = 0,
  --               character = 0,
  --             },
  --             ['end'] = {
  --               line = line_count - 1,
  --               character = string.len(last_line) - 1,
  --             },
  --           },
  --         }, handler, req_bufnr)
  --       end
  --     end,
  --   },
  -- },
  {
    'OmniSharp/omnisharp-vim',
    event = "VeryLazy",
    ft = { 'cs' },
  },
  -- LSP Plugins
  { 'Bilal2453/luvit-meta',   lazy = true },

  require 'kickstart.plugins.debug',

  -- require 'kickstart.plugins.autopairs',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  -- require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },

  -- SMART OPEN for Telescope
  -- {
  --   'danielfalk/smart-open.nvim',
  --   branch = '0.2.x',
  --   config = function()
  --     require('telescope').load_extension 'smart_open'
  --   end,
  --   dependencies = {
  --     'kkharji/sqlite.lua',
  --     -- Only required if using match_algorithm fzf
  --     { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
  --     -- Optional.  If installed, native fzy will be used when match_algorithm is fzy
  --     { 'nvim-telescope/telescope-fzy-native.nvim' },
  --   },
  -- },
  {
    'smartpde/telescope-recent-files',
    event = 'VeryLazy',
    opts = {
      only_cwd = true,
    }
  },
  --FOLD UFO
  {
    'kevinhwang91/nvim-ufo',
    event = 'VeryLazy',
    dependencies = { 'kevinhwang91/promise-async', event = 'BufRead' },
    config = function()
      require('ufo').setup()

      vk.set('n', 'zao', require('ufo').openAllFolds, { desc = '[A]ll [O]pen' })
      vk.set('n', 'zac', require('ufo').closeAllFolds, { desc = '[A]ll [C]lose' })

      vk.set('n', 'zf', 'zf', { desc = '[F]old create' })
      vk.set('n', 'zc', 'zc', { desc = '[C]lose fold under cursor' })
      vk.set('n', 'zo', 'zo', { desc = '[O]pen fold under cursor' })
      vk.set('n', 'zt', 'za', { desc = '[T]oggle fold under cursor' })


      -- NOTE: Fold up setup
      vim.o.foldcolumn = '0' -- '0' is not bad
      vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
  },

  -- using lazy.nvim
  -- {
  --   'S1M0N38/love2d.nvim',
  --   cmd = 'LoveRun',
  --   opts = {},
  --   keys = {},
  -- },

  -- Cool highlight in visual mode
  {
    'wurli/visimatch.nvim',
    event = "ModeChanged",
    opts = {
      -- The highlight group to apply to matched text
      hl_group = 'CursorIM',
      -- The minimum number of selected characters required to trigger highlighting
      chars_lower_limit = 1,
      -- The maximum number of selected lines to trigger highlighting for
      lines_upper_limit = 999,
      -- By default, visimatch will highlight text even if it doesn't have exactly
      -- the same spacing as the selected region. You can set this to `true` if
      -- you're not a fan of this behaviour :)
      strict_spacing = true,
      -- Visible buffers which should be highlighted. Valid options:
      -- * `"filetype"` (the default): highlight buffers with the same filetype
      -- * `"current"`: highlight matches in the current buffer only
      -- * `"all"`: highlight matches in all visible buffers
      -- * A function. This will be passed a buffer number and should return
      --   `true`/`false` to indicate whether the buffer should be highlighted.
      buffers = 'all',
      -- Case-(in)nsitivity for matches. Valid options:
      -- * `true`: matches will never be case-sensitive
      -- * `false`/`{}`: matches will always be case-sensitive
      -- * a table of filetypes to use use case-insensitive matching for.
      case_insensitive = { --[[ 'markdown', 'text', 'help' ]]
      },
    },
  },
  -- {
  --   'jiaoshijie/undotree',
  --   dependencies = 'nvim-lua/plenary.nvim',
  --   config = true,
  --   opts = {
  --     float_diff = true, -- using float window previews diff, set this `true` will disable layout option
  --     layout = 'left_left_bottom', -- "left_bottom", "left_left_bottom"
  --     position = 'left', -- "right", "bottom"
  --     ignore_filetype = { 'undotree', 'undotreeDiff', 'qf', 'TelescopePrompt', 'spectre_panel', 'tsplayground' },
  --     window = {
  --       winblend = 40,
  --     },
  --     -- keymaps = {
  --     --   ['j'] = 'move_next',
  --     --   ['k'] = 'move_prev',
  --     --   ['gj'] = 'move2parent',
  --     --   ['J'] = 'move_change_next',
  --     --   ['K'] = 'move_change_prev',
  --     --   ['<cr>'] = 'action_enter',
  --     --   ['p'] = 'enter_diffbuf',
  --     --   ['q'] = 'quit',
  --     -- },
  --   },
  --   keys = {
  --     { '<leader>l', "<cmd>lua require('undotree').toggle()<cr>" },
  --   },
  -- },

  --toggleable undotree
  {
    'mbbill/undotree',
    event = 'VeryLazy',
    config = function()
      vim.cmd [[
        let g:undotree_WindowLayout=1
            let g:undotree_DiffpanelHeight=10
            " let g:undotree_DiffCommand = "delta"
            let g:undotree_SetFocusWhenToggle = 1
            let g:undotree_DiffCommand = "FC"
            let g:undotree_DiffAutoOpen = 0

            " if has("persistent_undo")
            "     let target_path = expand('~/.undodir')

            "     " create the directory and any parent directories
            "     " if the location does not exist.
            "     if !isdirectory(target_path)
            "         call mkdir(target_path, "p", 0700)
            "     endif

            "     let &undodir=target_path
            "     set undofile
            " endif
        ]]
      vk.set('n', '<leader>tl', vim.cmd.UndotreeToggle, { desc = '[T]oggle [Undo] tree' })
    end,
  },

  -- discord RPC
  {
    'vyfor/cord.nvim', event = 'InsertEnter'
  },
  { -- awersome Git wrapper
    'tpope/vim-fugitive', event = 'VeryLazy',
  },
  { 'hrsh7th/cmp-buffer', event = 'InsertEnter' },


  -- generate annotations
  {
    'danymat/neogen',
    event = 'VeryLazy',
    config = function(_, opts)
      require('neogen').setup(opts)
      vk.set('n', '<Leader>a', ":lua require('neogen').generate()<CR>", { desc = 'generate comments' })
    end,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    version = '*',
    opts = {
      size = 200,
      open_mapping = [[<leader>tt]],
      hide_numbers = false,
      autochdir = true,
      persistent_size = false,
      start_in_insert = true,
      insert_mappings = false,  -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      direction = 'vertical',
    },
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false,   -- This plugin is already lazy

    -- debugger setup
    --   config = function()
    --     local mason_reg = require 'mason-registry'
    --     local codelldb = mason_reg.get_package 'codelldb'
    --     local extension_path = codelldb:get_install_handle() .. '/extension/'
    --     local codelldb_path = extension_path .. 'adapter/codelldb'
    --     local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'
    --     local cfg = require 'rustaceanvim.config'

    --     vim.g.rustaceanvim = {
    --       dap = { adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path) },
    --     }
    --     vim.g.rustaceanvim = {
    --       dap = { adapter = cfg.get_codelldb_adapter(codelldb_path) },
    --     }
    --   end,
  },
  -- NOTE: debugger setup (there is a default config in kickstarter)
  -- {
  --   event = 'BufReadPost',
  --   'mfussenegger/nvim-dap',
  --   config = function()
  --     local dap, dapui = require 'dap', require 'dapui'

  --     dap.listeners.before.attach.dapui_config = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.launch.dapui_config = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.event_terminated.dapui_config = function()
  --       dapui.close()
  --     end
  --     dap.listeners.before.event_exited.dapui_config = function()
  --       dapui.close()
  --     end

  --     -- map('i', 'jk', '<ESC>')

  --     -- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

  --     -- Nvim DAP
  --     map('n', '<Leader>di', "<cmd>lua require'dap'.step_into()<CR>", { desc = 'Debugger step into' })
  --     map('n', '<Leader>dv', "<cmd>lua require'dap'.step_over()<CR>", { desc = 'Debugger step over' })
  --     map('n', '<Leader>du', "<cmd>lua require'dap'.step_out()<CR>", { desc = 'Debugger step out' })
  --     map('n', '<Leader>dc', "<cmd>lua require'dap'.continue()<CR>", { desc = 'Debugger continue' })
  --     map('n', '<Leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = 'Debugger toggle breakpoint' })
  --     map(
  --       'n',
  --       '<Leader>dd',
  --       "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  --       { desc = 'Debugger set conditional breakpoint' }
  --     )
  --     map('n', '<Leader>dq', "<cmd>lua require'dap'.terminate()<CR>", { desc = 'Debugger reset' })
  --     map('n', '<Leader>dl', "<cmd>lua require'dap'.run_last()<CR>", { desc = 'Debugger run last' })
  --   end,
  -- },
  --return {
  -- {
  --   "igorlfs/nvim-dap-view",
  --   -- dependencies = { "mfussenegger/nvim-dap" },
  --   ---@module 'dap-view'
  --   ---@type dapview.Config
  --   opts = {},
  -- },

  -- nodejs
  -- { 'neoclide/coc.nvim', branch = 'release' },

  {
    "sphamba/smear-cursor.nvim",
    event = 'VeryLazy',
    opts = {
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = true,

      -- Smear cursor when moving within line or to neighbor lines.
      -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
      smear_between_neighbor_lines = false,

      -- Draw the smear in buffer space instead of screen space when scrolling
      scroll_buffer_space = false,

      -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
      -- Smears will blend better on all backgrounds.
      legacy_computing_symbols_support = false,

      cursor_color = "#d7c483",
      -- Smear cursor in insert mode.
      -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
      smear_insert_mode = false,

      stiffness = 0.95,                     -- 0.6      [0, 1]
      trailing_stiffness = 0.6,             -- 0.4      [0, 1]
      stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
      trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
      damping = 0.95,                       -- 0.65     [0, 1]
      damping_insert_mode = 0.8,            -- 0.7      [0, 1]
      distance_stop_animating = 0.1,        -- 0.1      > 0
    },
    config = function(_, opts)
      require('smear_cursor').setup(opts)
      vim.api.nvim_create_user_command('SmearCursorToggle', function()
        require('smear_cursor').toggle()
      end, {})
    end,
  },

  -- New plugins go here
  --
  --
  --
  --
}, {
  git = { timeout = 1200 },
  change_detection = { enabled = true, notify = false },
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})


require('modules.keymaps')
require('modules.autodir_setup')

-- NOTE: Tab settings
vim.opt.expandtab = true
vim.bo.expandtab = true
vim.opt.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.modeline = false
vim.cmd 'set expandtab'
vim.cmd [[autocmd FileType * set expandtab]]

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'cs', -- For C# files
  callback = function()
    vim.opt.expandtab = true
    vim.opt.tabstop = 4
    vim.opt.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    vim.opt.expandtab = true
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'js',
  callback = function()
    vim.opt.expandtab = true
    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
  end,
})

vim.api.nvim_set_hl(0, 'MatchParen',
  { underline = true, underdouble = true, undercurl = false, fg = '#bb7744', sp = '#bb7744' })

-- vim.cmd 'cd %:p:h'
-- vim.cmd 'cd'
