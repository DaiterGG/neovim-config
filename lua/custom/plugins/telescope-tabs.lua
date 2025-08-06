-- NOTE: attempt to make tabs isolated with stock cd instead of tcd for other plugins support
local TabLastSelect = {}
local TabCwd = {}

local cmd = vim.api.nvim_create_autocmd
vim.cmd 'silent cd %:p:h'
TabCwd[vim.api.nvim_get_current_tabpage()] = vim.fn.getcwd()

-- track cwd
cmd("DirChanged", {
  callback = function()
    TabCwd[vim.api.nvim_get_current_tabpage()] = vim.fn.getcwd()
  end
})
-- set cwd on new tab
cmd("TabNewEntered", {
  callback = function()
    vim.cmd('silent cd %:p:h')
    TabCwd[vim.api.nvim_get_current_tabpage()] = vim.fn.getcwd()
  end,
})

JustEnteredTab = false
-- change cwd on tab change
cmd("TabEnter", {
  callback = function()
    JustEnteredTab = true
  end,
})
cmd("BufEnter", {
  callback = function()
    if JustEnteredTab then
      local tabcwd = TabCwd[vim.api.nvim_get_current_tabpage()]
      vim.cmd(tabcwd and ('silent cd ' .. tabcwd) or '')
      JustEnteredTab = false
    end
  end,
})
-- track tab selection time
cmd("TabEnter", {
  callback = function()
    local tab_id = vim.api.nvim_get_current_tabpage()
    TabLastSelect[tab_id] = vim.loop.now()
  end
})

-- at least one tab already open
for _, tab_id in ipairs(vim.api.nvim_list_tabpages()) do
  TabLastSelect[tab_id] = TabLastSelect[tab_id] or vim.loop.now()
end

return {
  -- 'LukasPietzschmann/telescope-tabs',
  'DaiterGG/telescope-recent-tabs',
  event = 'VeryLazy',
  config = function()
    require('telescope').load_extension 'telescope-tabs'
    require('telescope-tabs').setup {
      entry_formatter = function(tab_id, buffer_ids, file_names, file_paths, is_current)
        local entry_string = file_names[1]
        if entry_string == '' then return '  New Tab' end
        return (is_current and '> ' or '  ') .. ReversePathFn({}, file_paths[1])
      end,
      sort_function = function(tab_id_a, buffer_ids_a, file_names_a, file_paths_a, is_current_a, tab_id_b, buffer_ids_b,
                               file_names_b, file_paths_b, is_current_b)
        if is_current_b then
          return true
        elseif is_current_a then
          return false
        end

        local time_a = TabLastSelect[tab_id_a]
        local time_b = TabLastSelect[tab_id_b]

        return time_a > time_b
      end
    }
    vim.keymap.set('n', '<leader>u', function()
      require('telescope-tabs').list_tabs()
    end)
  end,
  dependencies = { 'nvim-telescope/telescope.nvim' },
}
