-- neovim-tree requires this
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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

-- indent fix
vim.api.nvim_create_autocmd('VimEnter', {
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

local opts = { noremap = true, silent = true }
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

  -- NOTE: Disabled for now (bad detections)
  --'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- Use `opts = {}` to force a plugin to be loaded.
  --

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
    ft = { 'cs' },
  },
  -- LSP Plugins
  { 'Bilal2453/luvit-meta' },

  {
    'xero/miasma.nvim',

    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'miasma'
    end,
  },
  -- require 'kickstart.plugins.autopairs',

  -- require 'kickstart.plugins.debug',
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
  'smartpde/telescope-recent-files',

  --FOLD UFO
  {
    'kevinhwang91/nvim-ufo',
  },

  {
    'kevinhwang91/promise-async',
  },

  -- using lazy.nvim
  {
    'S1M0N38/love2d.nvim',
    cmd = 'LoveRun',
    opts = {},
    keys = {},
  },
  -- NEW DISCORD RPC
  -- {
  --   'IogaMaster/neocord',
  --   event = 'VeryLazy',
  -- },
  -- {
  --   'andweeb/presence.nvim',
  -- },

  -- Cool highlight in visual mode
  {
    'wurli/visimatch.nvim',
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
    lazy = false,
    cmd = 'UndotreeToggle',
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

  {
    'vyfor/cord.nvim',
  },
  -- awersome Git wrapper
  {
    'tpope/vim-fugitive',
  },
  { 'hrsh7th/cmp-buffer' },

  -- generate annotations
  {
    'danymat/neogen',
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    opts = {
      size = 200,
      open_mapping = [[<leader>tt]],
      hide_numbers = false,
      autochdir = true,
      persistent_size = false,
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      direction = 'vertical',
    },
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    lazy = false, -- This plugin is already lazy

    -- debugger setup
    config = function()
      local mason_reg = require 'mason-registry'
      local codelldb = mason_reg.get_package 'codelldb'
      local extension_path = codelldb:get_install_path() .. '/extension/'
      local codelldb_path = extension_path .. 'adapter/codelldb'
      local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'
      local cfg = require 'rustaceanvim.config'

      -- vim.g.rustaceanvim = {
      --   dap = { adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path) },
      -- }
      -- vim.g.rustaceanvim = {
      --   dap = { adapter = cfg.get_codelldb_adapter(codelldb_path) },
      -- }
    end,
  },
  -- debugger setup
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap, dapui = require 'dap', require 'dapui'

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      -- add yours here

      local map = vim.keymap.set

      -- map('i', 'jk', '<ESC>')

      -- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

      -- Nvim DAP
      map('n', '<Leader>di', "<cmd>lua require'dap'.step_into()<CR>", { desc = 'Debugger step into' })
      map('n', '<Leader>dv', "<cmd>lua require'dap'.step_over()<CR>", { desc = 'Debugger step over' })
      map('n', '<Leader>du', "<cmd>lua require'dap'.step_out()<CR>", { desc = 'Debugger step out' })
      map('n', '<Leader>dc', "<cmd>lua require'dap'.continue()<CR>", { desc = 'Debugger continue' })
      map('n', '<Leader>db', "<cmd>lua require'dap'.toggle_breakpoint()<CR>", { desc = 'Debugger toggle breakpoint' })
      map(
        'n',
        '<Leader>dd',
        "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
        { desc = 'Debugger set conditional breakpoint' }
      )
      map('n', '<Leader>dq', "<cmd>lua require'dap'.terminate()<CR>", { desc = 'Debugger reset' })
      map('n', '<Leader>dl', "<cmd>lua require'dap'.run_last()<CR>", { desc = 'Debugger run last' })
    end,
  },

  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      require('dapui').setup()
    end,
  },
  -- { 'neoclide/coc.nvim', branch = 'release' },
  -- New plugins go here
  --
  --
  --
  --
}, {
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

local c_c = vim.api.nvim_replace_termcodes('<C-c>', true, true, true)

-- NOTE: Command mode keymap
local cmp = require 'cmp'
local wrap1 = function()
  cmp.select_next_item()
end
local wrap2 = function()
  cmp.select_prev_item()
end
vk.set('c', '<C-h>', wrap1, opts)
vk.set('c', '<C-t>', wrap2, opts)
vk.set('c', '<C-n>', '<C-t><C-h>', { remap = true })

vk.set('c', '<c-e>', '<left>', { noremap = false })
vk.set('c', '<c-u>', '<right>', { noremap = false })

-- NOTE: Terminal mode keymap
vk.set('t', '<Esc>', '<C-\\><C-n>', opts)

vk.set('t', '<C-h>', '<Down>', { remap = true })
vk.set('t', '<C-t>', '<Up>', { remap = true })
vk.set('t', '<C-u>', '<Right>', { remap = true })
vk.set('t', '<C-e>', '<Left>', { remap = true })
vk.set('t', '<A-c>', '<C-c>', { remap = true })

vk.set('t', '<A-e>', '<C-\\><C-n><C-w>h', { remap = true })
vk.set('t', '<A-u>', '<C-\\><C-n><C-w>l', { remap = true })
vk.set('t', '<A-h>', '<C-\\><C-n><C-w>j', { remap = true })
vk.set('t', '<A-t>', '<C-\\><C-n><C-w>k', { remap = true })
vk.set('t', '<A-,>', '<C-\\><C-n><C-w>>a', { remap = true })
vk.set('t', '<A-.>', '<C-\\><C-n><C-w><lt>a', { remap = true })
vk.set('t', '<A-+>', '<C-\\><C-n><C-w>+a', { remap = true })
vk.set('t', '<A-->', '<C-\\><C-n><C-w>-a', { remap = true })

-- NOTE: Insert mode keymap
vk.set('i', '<C-p>', '<C-r>"', opts)

vk.set('i', '<esc>', function()
  vim.api.nvim_feedkeys(c_c, 'm', false)
  local tl = require 'telescope'
  if tl.active then
    tl.actions.close()
  end
end, opts)

vk.set('i', '<A-w>', '<C-\\><C-n><cmd>w<CR>', { silent = true })
-- NOTE: Normal mode keymap

vk.set('n', '<esc>', function()
  vim.cmd 'nohlsearch'
  vim.api.nvim_feedkeys(c_c, 'm', false)
  local mc = require 'multicursor-nvim'
  mc.clearCursors()
end, opts)

vk.set('n', '<CR>', 'A<CR><Esc>', opts)

-- Diagnostic keymaps
vk.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- split screen keymaps
vk.set('n', '<a-e>', '<C-w>h')
vk.set('n', '<a-u>', '<C-w>l')
vk.set('n', '<a-h>', '<C-w>j')
vk.set('n', '<a-t>', '<C-w>k')
vk.set('n', '<a-,>', '<C-w>>', opts)
vk.set('n', '<a-.>', '<C-w><lt>', opts)
vk.set('n', '<a-+>', '<C-w>+')
vk.set('n', '<a-->', '<C-w>-')

-- tabs
vk.set('n', '<leader><tab>', ':tabnext<CR>', { desc = 'Next tab' })

-- my old open terminal command
-- vk.set('n', '<leader>nt', '<C-w>99l<C-w>99k<C-w>o:8 split<CR>:term<CR>', { noremap = true, silent = true, desc = '[N]ew [T]erminal tile' })

vk.set('n', '<Leader>a', ":lua require('neogen').generate()<CR>", { desc = 'generate comments' })

-- Quick save
vk.set('n', '<A-w>', '<cmd>w<CR>', { silent = true })

require('ufo').setup()

-- folds
vk.set('n', 'zt', 'za', { desc = '[T]oggle fold under cursor' })
vk.set('n', 'zat', 'zA', { desc = '[A]ll [T]oggle fold under cursor' })
vk.set('n', 'zao', require('ufo').openAllFolds, { desc = '[A]ll [O]pen' })
vk.set('n', 'zac', require('ufo').closeAllFolds, { desc = '[A]ll [C]lose' })
vk.set('n', 'zad', 'zD', { desc = '[A]ll [D]elete under cursor' })
-- vk.set('n', 'zac', 'zC', { desc = '[A]ll [C]lose under cursor' })
-- vk.set('n', 'zao', 'zO', { desc = '[A]ll [O]pen under cursor' })
vk.set('n', 'zaf', 'zE', { desc = 'delete [A]ll folds in a [F]ile' })

vk.set('n', 'zAA', function() end, { desc = '' })
vk.set('n', 'zLL', function() end, { desc = '' })
vk.set('n', 'zss', function() end, { desc = '' })
vk.set('n', 'zee', function() end, { desc = '' })
vk.set('n', 'zgg', function() end, { desc = '' })
vk.set('n', 'zMM', function() end, { desc = '' })
vk.set('n', 'zHH', function() end, { desc = '' })
vk.set('n', 'zvv', function() end, { desc = '' })
vk.set('n', 'zww', function() end, { desc = '' })
vk.set('n', 'zbb', function() end, { desc = '' })
vk.set('n', 'zDD', function() end, { desc = '' })
vk.set('n', 'zCC', function() end, { desc = '' })
vk.set('n', 'zEE', function() end, { desc = '' })
vk.set('n', 'zRR', function() end, { desc = '' })
vk.set('n', 'zOO', function() end, { desc = '' })
vk.set('n', 'z<CR><CR>', function() end, { desc = '' })

-- Jump to previous locations
-- my right ctrl is in akward position on my laptop
vk.set('n', '<C-d>', '<C-o>')
vk.set('n', '<C-n>', '<C-i>')

-- Navigation rebind
vk.set('n', 'k', 't', opts)
vk.set('n', 't', 'gk', opts) -- up

vk.set('n', 'h', 'gj', opts) -- down
vk.set('n', 'j', 'e', opts)
vk.set('n', 'e', 'h', opts) -- left

vk.set('n', 'u', 'l', opts) -- right
vk.set('n', 'l', 'u', opts)
vk.set('n', 'L', 'U', opts)

vk.set('n', '<C-e>', '11h', opts)
vk.set('n', '<C-u>', '11l', opts)

vk.set('n', '<C-h>', '11gj', opts)
vk.set('n', '<C-t>', '11gk', opts)

-- MoveLine
-- vk.set('n', 'H', ':m .+1<CR>==', opts)
-- vk.set('n', 'T', ':m .-2<CR>==', opts)

-- NOTE: Formating stuff
local toggle_format = true
-- toggle autoformat
vk.set('n', '<leader>tf', function()
  toggle_format = not toggle_format
end, { noremap = true, silent = true, desc = '[T]oggle [F]ormat On Save' })

--Auto formatting
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    if toggle_format then
      require('conform').format { async = false, lsp_format = 'fallback' }
    end
  end,
})
-- Manual formating
vk.set('n', '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { noremap = true, silent = true, desc = '[F]ormat Document' })

-- toggle virtual text
vk.set('n', '<leader>td', function()
  vim.diagnostic.config { virtual_text = not vim.diagnostic.config().virtual_text }
end, { noremap = true, silent = true, desc = '[T]oggle [D]iagnostics virtual text' })
-- NOTE: Visual mode keymap

vk.set('v', 'k', 't', opts)
vk.set('v', 't', 'gk', opts) -- up

vk.set('v', 'h', 'gj', opts) -- down
vk.set('v', 'j', 'e', opts)
vk.set('v', 'e', 'h', opts) -- left

vk.set('v', 'u', 'l', opts) -- right
vk.set('v', 'l', 'u', opts)
vk.set('v', 'L', 'U', opts)

vk.set('v', '<C-e>', '11h', opts)
vk.set('v', '<C-u>', '11l', opts)

vk.set('v', '<C-h>', '11gj', opts)
vk.set('v', '<C-t>', '11gk', opts)

vk.set('v', '$', '$h', opts)

-- MoveLine
-- now in mini.move
-- vk.set('v', 'H', ":m '>+1<CR>gv=gv", opts)
-- vk.set('v', 'T', ":m '<-2<CR>gv=gv", opts)

--Paste over
vk.set('v', 'p', 'P', opts)
vk.set('v', 'P', 'p', opts)

--Replace
vk.set('v', '<C-r>', 'y:%s/<C-r>"/<C-r>"/gc<Left><Left><Left>', { desc = 'Replace' })

-- vk.set('v', '<C-_>', 'y/<C-r>"<CR>', { remap = true })

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

-- Somone mention that zig is better for windows
-- require('nvim-treesitter.install').compilers = { 'clang', 'zig' }
-- require('nvim-treesitter.install').compilers = { 'cc', 'gcc', 'cl', 'zig' }
-- require('nvim-treesitter.install').prefer_git = false

-- NOTE: Register configurations for different directories
local dir_config = require 'autodir'

-- Noita run
dir_config.setup_directory_config('Noita', function()
  vk.set(
    'n',
    '<leader>nn',
    '<C-w>k<C-w>k<C-w>k<C-w>o<C-w>o<C-w>o<C-w>o:sp<CR>:term<CR>D:<CR>cd D:/SteamLibrary/steamapps/common/Noita<CR>noita_dev.exe<CR><C-\\><C-n><C-w>18-G<C-w>k',
    { noremap = true, silent = true, desc = 'Open noita_dev' }
  )
  vk.set(
    'n',
    '<leader>nt',
    ':sp<CR>:term<CR>D:<CR>cd D:/SteamLibrary/steamapps/common/Noita/mods/kickining_way<CR>D:/SteamLibrary/steamapps/common/Noita/noita.exe -splice_pixel_scene files/biome_impl/level/wang.png -x 3000 -y 3000<CR><C-\\><C-n>:q<CR><C-w>18+',
    { noremap = true, silent = true, desc = 'Build map' }
  )
end)

-- For LOVE
dir_config.setup_directory_config('LOVE', function()
  vk.set('n', '<leader>nr', '<cmd>w<cr><cmd>LoveRun<cr>', { desc = 'Run LÖVE' })
  vk.set('n', '<leader>ns', '<cmd>LoveStop<cr>', { desc = 'Stop LÖVE' })
end)
-- For quick board
dir_config.setup_directory_config('quick-board', function()
  --
end)

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
-- vim.api.nvim_create_autocmd('VimLeavePre', {
--   pattern = '*',
--   callback = function()
--     vim.cmd 'wqa!'
--   end,
-- })

local delete_shada = function()
  local keys = vim.api.nvim_replace_termcodes(
    ':term<CR>aC:<CR>cd "C:\\Users\\User1\\AppData\\Local\\nvim-data"<CR>del shada<CR>Y<CR><C-\\><C-n><leader>h<CR>',
    true,
    false,
    true
  )
  vim.api.nvim_feedkeys(keys, 'm', false)
end

vk.set('n', 'ds', delete_shada, { desc = 'Open terminal' })

vim.g.editorconfig = false
--color scheme by default
vim.cmd 'colorscheme miasma'
vim.opt.guicursor = 'n-v-c:block,i:ver10'

-- NOTE: set current directory on startup
pcall(function()
  vim.cmd 'cd %:h'
end)
vim.cmd 'cd'

vk.set('n', '<leader>te', function()
  local pwd = 'NvimTreeToggle ' .. vim.fn.getcwd()
  vim.cmd('' .. pwd)
end, { desc = '[T]oggle [E]xplorer', noremap = true, silent = true })

vim.g.autoformat = false

-- NOTE: Fold up setup
vim.o.foldcolumn = '0' -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.title = true

vim.o.titlestring = [[%t – %F]]

vim.api.nvim_set_hl(0, 'LspReferenceText', { undercurl = false, fg = '#d7c483', bg = '#43492a', sp = '#fd9720' })
vim.api.nvim_set_hl(0, 'LspReferenceRead', { undercurl = false, fg = '#d7c483', bg = '#43492a', sp = '#fd9720' })
vim.api.nvim_set_hl(0, 'LspReferenceWrite', { undercurl = false, fg = '#d7c483', bg = '#43492a', sp = '#fd9720' })
-- LspReferenceText xxx gui=bold,undercurl guifg=#d7c483 guibg=#43492a guisp=#fd9720

-- NOTE: Comment setup
local ft = require 'Comment.ft'

--1. Using method signature
-- Set only line comment or both
-- You can also chain the set calls
-- ft.set('yaml', '#%s').set('javascript', { '//%s', '/*%s*/' })

-- 2. Metatable magic
-- ft.javascript = { '//%s', '/*%s*/' }
-- ft.yaml = '#%s'

-- 3. Multiple filetypes
ft({ 'conf', 'frag', 'shader', 'glsl', 'vert', 'txt' }, { '//%s', '/*%s*/' })
-- ft({ 'toml', 'graphql' }, '#%s')
vim.diagnostic.config { virtual_text = true }
