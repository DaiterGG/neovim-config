local vk = vim.keymap
-- NOTE: Debug keymap
vk.set({ 'i', 'n' }, '<f10>', function()
    vim.show_pos()
  end,
  {})

-- NOTE: Command mode keymap
vk.set('c', '<C-n>', '<C-t><C-h>', { remap = true })

vk.set('c', '<A-h>', '<down>', { noremap = false })
vk.set('c', '<A-t>', '<up>', { noremap = false })
vk.set('c', '<A-e>', '<left>', { noremap = false })
vk.set('c', '<A-u>', '<right>', { noremap = false })

-- NOTE: Terminal mode keymap
vk.set('t', '<C-c>', '<C-\\><C-n>', opts)
vk.set('t', '<A-c>', '<C-c>', { remap = false })

vk.set('t', '<Esc>', '<C-\\><C-n>', opts)

vk.set('t', '<C-h>', '<Down>', { remap = true })
vk.set('t', '<C-t>', '<Up>', { remap = true })
vk.set('t', '<C-u>', '<Right>', { remap = true })
vk.set('t', '<C-e>', '<Left>', { remap = true })

vk.set('t', '<A-e>', '<C-\\><C-n><C-w>h', { remap = true })
vk.set('t', '<A-u>', '<C-\\><C-n><C-w>l', { remap = true })
vk.set('t', '<A-h>', '<C-\\><C-n><C-w>j', { remap = true })
vk.set('t', '<A-t>', '<C-\\><C-n><C-w>k', { remap = true })
vk.set('t', '<A-,>', '<C-\\><C-n><C-w>>a', { remap = true })
vk.set('t', '<A-.>', '<C-\\><C-n><C-w><lt>a', { remap = true })
vk.set('t', '<A-+>', '<C-\\><C-n><C-w>+a', { remap = true })
vk.set('t', '<A-->', '<C-\\><C-n><C-w>-a', { remap = true })

-- NOTE: Insert mode keymap
vk.set('i', '<C-c>', '<Esc>', opts)

vk.set('i', '<C-p>', '<C-r>"', opts)


vk.set('i', '<A-w>', '<C-\\><C-n><cmd>w<CR>', { silent = true })

-- NOTE: Visual mode keymap
vk.set('v', '<C-c>', '<Esc>', opts)

vk.set('v', 'k', 't', opts)
vk.set('v', 't', 'gk', opts) -- up

vk.set('v', 'h', 'gj', opts) -- down
vk.set('v', 'j', 'e', opts)
vk.set('v', 'e', 'h', opts)  -- left

vk.set('v', 'u', 'l', opts)  -- right
vk.set('v', 'l', 'u', opts)
vk.set('v', 'L', 'U', opts)

vk.set('v', '<C-e>', '6h', opts)
vk.set('v', '<C-u>', '6l', opts)

vk.set('v', '<C-h>', '6gj', opts)
vk.set('v', '<C-t>', '6gk', opts)

vk.set('v', '$', '$h', opts)

-- MoveLine
-- now in mini.move
-- vk.set('v', 'H', ":m '>+1<CR>gv=gv", opts)
-- vk.set('v', 'T', ":m '<-2<CR>gv=gv", opts)

--Paste over
vk.set('v', 'p', 'P', opts)
vk.set('v', 'P', 'p', opts)

--Replace
vk.set('v', '<C-r>', '"1y:%s/<C-r>1/<C-r>1/gc<Left><Left><Left>', { desc = 'Replace' })

-- vk.set('v', '<C-_>', 'y/<C-r>"<CR>', { remap = true })
-- NOTE: Normal mode keymap
--
vk.set({ 'n' }, '<C-c>', '<Esc>:noh<cr>', opts)
vk.set({ 'o' }, '<C-c>', '<Esc>:noh<cr>', opts)

vk.set('n', '<CR>', 'A<CR><Esc>', opts)

-- vk.set('n', 'ga', 'gi', { desc = 'Go to last inserted text' })

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


-- my old open terminal command
-- vk.set('n', '<leader>nt', '<C-w>99l<C-w>99k<C-w>o:8 split<CR>:term<CR>', { noremap = true, silent = true, desc = '[N]ew [T]erminal tile' })

-- Quick save
vk.set('n', '<A-w>', '<cmd>w<CR>', { silent = true })


-- Jump to previous locations
-- my right ctrl is in akward position on my laptop
vk.set('n', '<C-d>', '<C-o>')
vk.set('n', '<C-n>', '<C-i>')

-- Navigation rebind
vk.set('n', 'k', 't', opts)
vk.set('n', 't', 'gk', opts) -- up

vk.set('n', 'h', 'gj', opts) -- down
vk.set('n', 'j', 'e', opts)
vk.set('n', 'e', 'h', opts)  -- left

vk.set('n', 'u', 'l', opts)  -- right
vk.set('n', 'l', 'u', opts)
vk.set('n', 'L', 'U', opts)

vk.set('n', '<C-e>', '6h', opts)
vk.set('n', '<C-u>', '6l', opts)

vk.set('n', '<C-h>', '6gj', opts)
vk.set('n', '<C-t>', '6gk', opts)

-- MoveLine
-- vk.set('n', 'H', ':m .+1<CR>==', opts)
-- vk.set('n', 'T', ':m .-2<CR>==', opts)

-- toggle virtual text
local desc = '[T]oggle [D]iagnostics virtual text'
ToggleDiagnostic = function()
  vk.set('n', '<leader>td', function()
    vim.diagnostic.config { virtual_text = not vim.diagnostic.config().virtual_text }
    ToggleDiagnostic()
  end, { noremap = true, silent = true, desc = (vim.diagnostic.config().virtual_text and "[ON] " or "[OFF] ") .. desc })
end
ToggleDiagnostic()

vk.set('n', '<leader>ds', function()
  local shada_dir = vim.fn.stdpath('state') .. '\\shada\\'

  local del_cmds = {}
  for c = 97, 122 do -- ASCII range for a-z
    table.insert(del_cmds, 'del main.shada.tmp.' .. string.char(c))
  end
  local cmd = table.concat({ ':term<CR>a',
    'cd /d "' .. shada_dir:gsub('/', '\\') .. '"<CR>',
    table.concat(del_cmds, '<CR>'),
    '<C-\\><C-n>' })

  local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
  vim.api.nvim_feedkeys(keys, 'm', false)
end, { desc = '[D]elete [S]hada temporary files' })
