-- NOTE: Directory specific configuration
local dir_config = require 'autodir'

local map = vim.keymap.set
--for Noita
dir_config.directory_autocmd('Noita', function()
  map(
    'n',
    '<leader>nn',
    '<C-w>k<C-w>k<C-w>k<C-w>o<C-w>o<C-w>o<C-w>o:sp<CR>:term<CR>D:<CR>cd D:/SteamLibrary/steamapps/common/Noita<CR>noita_dev.exe<CR><C-\\><C-n><C-w>18-G<C-w>k',
    { noremap = true, silent = true, desc = 'Open noita_dev' }
  )
  map(
    'n',
    '<leader>nt',
    ':sp<CR>:term<CR>D:<CR>cd D:/SteamLibrary/steamapps/common/Noita/mods/kickining_way<CR>D:/SteamLibrary/steamapps/common/Noita/noita.exe -splice_pixel_scene files/biome_impl/level/wang.png -x 3000 -y 3000<CR><C-\\><C-n>:q<CR><C-w>18+',
    { noremap = true, silent = true, desc = 'Build map' }
  )
end)

-- NT_EW
dir_config.directory_autocmd('noita_entangled_worlds', function()
  map('n', '<leader>ns', function()
    OpenTermThen('set NP_DISABLE_STEAM=1 & set NP_SKIP_MOD_CHECK=1 & set NP_NOITA_ADDR=127.0.0.1:21251')
  end, { desc = 'Setup' })
end)
-- For LOVE
dir_config.directory_autocmd('LOVE', function()
  map('n', '<leader>nr', '<cmd>w<cr><cmd>LoveRun<cr>', { desc = 'Run LÖVE' })
  map('n', '<leader>ns', '<cmd>LoveStop<cr>', { desc = 'Stop LÖVE' })
end)

-- Startup
vim.g.set_cur_dir = function()
  vim.cmd('cd ' .. vim.fn.stdpath('config'))
end
dir_config.directory_autocmd('WindowsApps', function()
  vim.g.set_cur_dir()
end)
dir_config.directory_autocmd('system32', function()
  vim.g.set_cur_dir()
end)
