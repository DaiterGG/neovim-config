-- this is my 'project specific configuration' plugin
-- usage:
-- for cd C:/Programs/FolderName/subfolder/
-- init.lua:
--   local dir_config = require 'autodir'
--   dir_config.setup_directory_config('FolderName', function()
--     ...
--   }

local M = {}
-- Table to store directory configurations
local directory_configs = {}

-- Check if current directory contains target directory in its path
local function is_in_directory(target_dir)
  -- local cwd = vim.fn.getcwd():gsub('\\', '/') -- Normalize path for Windows
  -- local parts = vim.split(cwd, '/')
  -- for _, part in ipairs(parts) do
  --   if part == target_dir then
  --     return true
  --   end
  -- end
  -- return false

  -- Make it any matching part
  return vim.fn.getcwd():find(target_dir) ~= nil
end

-- Execute registered functions for matching directories
local function check_directory_configs()
  for _, config in ipairs(directory_configs) do
    if is_in_directory(config.dir) then
      config.func()
    end
  end
end

-- Setup function to register directory configurations
function M.setup_directory_config(dir, func)
  table.insert(directory_configs, {
    dir = dir,
    func = func,
  })

  -- Immediately check if we're already in the target directory
  if is_in_directory(dir) then
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
