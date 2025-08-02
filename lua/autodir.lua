-- this is my 'project specific configuration' plugin
-- usage:
-- for cd C:/Programs/FolderName/subfolder/
-- init.lua:
--   local dir_config = require 'autodir'
-- dir_config.directory_autocmd('FolderName', function()
--     ...
--   }

local M = {}
-- Table to store directory configurations
local directory_configs = {}

-- Execute registered functions for matching directories
local function check_directory_configs()
  for _, config in ipairs(directory_configs) do
    if vim.fn.getcwd():find(config.dir) ~= nil then
      config.func()
    end
  end
end

-- Setup function to register directory configurations
function M.directory_autocmd(dir, func)
  table.insert(directory_configs, {
    dir = dir,
    func = func,
  })

  -- Immediately check if we're already in the target directory
  if vim.fn.getcwd():find(dir) ~= nil then
    func()
  end
end

-- Set up autocommand for directory changes
local config_group = vim.api.nvim_create_augroup('DirectoryConfigGroup', { clear = true })
vim.api.nvim_create_autocmd('DirChanged', {
  group = config_group,
  pattern = 'global',
  callback = check_directory_configs,
})
return M
