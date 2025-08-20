local vk = vim.keymap
local map = vim.keymap.set
-- NOTE: Debug keymap
map({ 'i', 'n' }, '<f10>', function()
    vim.show_pos()
  end,
  {})

-- NOTE: All modes keymaps

-- NOTE: Command mode keymap

-- map('c', '<C-n>', '<C-t><C-h>', { remap = true })

map('c', '<A-h>', '<down>', { noremap = false })
map('c', '<A-t>', '<up>', { noremap = false })
map('c', '<A-e>', '<left>', { noremap = false })
map('c', '<A-u>', '<right>', { noremap = false })

-- NOTE: Terminal mode keymap

-- map('t', '<C-c>', '<C-\\><C-n>', opts)
map('t', '<A-c>', '<C-c>', { remap = false })

map('t', '<Esc>', '<C-\\><C-n>', opts)

map('t', '<C-h>', '<Down>', { remap = true })
map('t', '<C-t>', '<Up>', { remap = true })
map('t', '<C-u>', '<Right>', { remap = true })
map('t', '<C-e>', '<Left>', { remap = true })

map('t', '<A-e>', '<C-\\><C-n><C-w>h', { remap = true })
map('t', '<A-u>', '<C-\\><C-n><C-w>l', { remap = true })
map('t', '<A-h>', '<C-\\><C-n><C-w>j', { remap = true })
map('t', '<A-t>', '<C-\\><C-n><C-w>k', { remap = true })
map('t', '<A-,>', '<C-\\><C-n><C-w>>a', { remap = true })
map('t', '<A-.>', '<C-\\><C-n><C-w><lt>a', { remap = true })
map('t', '<A-+>', '<C-\\><C-n><C-w>+a', { remap = true })
map('t', '<A-->', '<C-\\><C-n><C-w>-a', { remap = true })

-- NOTE: Insert mode keymap

-- map('i', '<C-c>', '<Esc>', opts)

map('i', '<C-p>', '<C-r>"', opts)


map('i', '<A-w>', '<C-\\><C-n><cmd>w<CR>', { silent = true })

-- NOTE: Visual mode keymap

-- map('v', '<C-c>', '<Esc>', opts)

map('v', 'k', 't', opts)
map('v', 't', 'gk', opts) -- up

map('v', 'h', 'gj', opts) -- down
map('v', 'j', 'e', opts)
map('v', 'e', 'h', opts)  -- left

map('v', 'u', 'l', opts)  -- right
map('v', 'l', 'u', opts)
map('v', 'L', 'U', opts)

map('v', '<C-e>', '6h', opts)
map('v', '<C-u>', '6l', opts)

map('v', '<C-h>', '6gj', opts)
map('v', '<C-t>', '6gk', opts)

map('v', '$', '$h', opts)

-- MoveLine
-- now in mini.move
-- map('v', 'H', ":m '>+1<CR>gv=gv", opts)
-- map('v', 'T', ":m '<-2<CR>gv=gv", opts)

--Paste over
map('v', 'p', 'P', opts)
map('v', 'P', 'p', opts)

--Replace
map('v', '<C-r>', '"1y:%s/<C-r>1/<C-r>1/gc<Left><Left><Left>', { desc = 'Replace' })

-- map('v', '<C-_>', 'y/<C-r>"<CR>', { remap = true })
-- NOTE: Normal mode keymap

map('n', '*', 'viw*<C-\\><C-n>')
-- map('n', '<C-c>', '<Esc>:noh<cr>', opts)

map('n', '<CR>', 'A<CR><Esc>', opts)

-- map('n', 'ga', 'gi', { desc = 'Go to last inserted text' })

-- Diagnostic keymaps
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- split screen keymaps
map('n', '<a-e>', '<C-w>h')
map('n', '<a-u>', '<C-w>l')
map('n', '<a-h>', '<C-w>j')
map('n', '<a-t>', '<C-w>k')
map('n', '<a-,>', '<C-w>>', opts)
map('n', '<a-.>', '<C-w><lt>', opts)
map('n', '<a-+>', '<C-w>+')
map('n', '<a-->', '<C-w>-')



-- Quick save
map('n', '<A-w>', '<cmd>w<CR>', { silent = true })


-- Jump to previous locations
-- my right ctrl is in awkward position on my laptop
map('n', '<C-d>', '<C-o>')
map('n', '<C-n>', '<C-i>')

-- Navigation rebind
map('n', 'k', 't', opts)
map('n', 't', 'gk', opts) -- up

map('n', 'h', 'gj', opts) -- down
map('n', 'j', 'e', opts)
map('n', 'e', 'h', opts)  -- left

map('n', 'u', 'l', opts)  -- right
map('n', 'l', 'u', opts)
map('n', 'L', 'U', opts)

map('n', '<C-e>', '6h', opts)
map('n', '<C-u>', '6l', opts)

map('n', '<C-h>', '6gj', opts)
map('n', '<C-t>', '6gk', opts)

-- map('n', '<leader>s<C-c>', '', opts)
-- MoveLine
-- map('n', 'H', ':m .+1<CR>==', opts)
-- map('n', 'T', ':m .-2<CR>==', opts)

-- toggle virtual text
local desc = '[T]oggle [D]iagnostics virtual text'
ToggleDiagnostic = function()
  map('n', '<leader>td', function()
    vim.diagnostic.config { virtual_text = not vim.diagnostic.config().virtual_text }
    ToggleDiagnostic()
  end, { noremap = true, silent = true, desc = (vim.diagnostic.config().virtual_text and "[ON] " or "[OFF] ") .. desc })
end
ToggleDiagnostic()

map('n', '<leader>ds', function()
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
