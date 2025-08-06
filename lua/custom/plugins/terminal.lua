return {

  'rebelot/terminal.nvim',
  -- init = function ()

  -- end
  event = 'VeryLazy',
  config = function()
    local map = vim.keymap.set
    local cmd = vim.api.nvim_create_autocmd

    require("terminal").setup({ autoclose = true })

    local TabTerm = {}
    TabTerm[vim.api.nvim_get_current_tabpage()] = { is_on = false }

    cmd("TabNewEntered", {
      callback = function()
        TabTerm[vim.api.nvim_get_current_tabpage()] = { is_on = false }
      end,
    })
    cmd("TermClose", {
      callback = function()
        TabTerm[vim.api.nvim_get_current_tabpage()] = { is_on = false, id = nil }
      end,
    })

    local term_layout = { open_cmd = "float", height = 1.0, width = 1.0 }
    -- toggle fn for kemap
    local toggle_term = function()
      local tab_id = vim.api.nvim_get_current_tabpage()
      local term = TabTerm[tab_id]
      local toggle = not term.is_on
      term.is_on = toggle
      local term_id = term.id
      if toggle then
        if term_id == nil then
          require("terminal").run('', { layout = term_layout })
          term.id = require("terminal").current_term_index()
        else
          require("terminal").open(tab_id)
        end

        local keys = vim.api.nvim_replace_termcodes("a", true, true, true)
        vim.api.nvim_feedkeys(keys, 'm', false)
      else
        require("terminal").close()
      end
    end
    map('n', '<leader>tt', toggle_term, { noremap = true, silent = true, desc = '[T]oggle [T]erminal' })
    map('t', '<A-t>', toggle_term, { noremap = true, silent = true, desc = '[T]oggle [T]erminal' })


    -- open if needed and focus terminal
    OpenTermOrNot = function()
      local tab_id = vim.api.nvim_get_current_tabpage()
      local term = TabTerm[tab_id]
      local already_on = term.is_on
      if not already_on then
        term.is_on = true
        local term_id = term.id
        if term_id == nil then
          require("terminal").run('', { layout = term_layout })
          term.id = require("terminal").current_term_index()
        else
          require("terminal").open(tab_id)
        end
      end
      local keys = vim.api.nvim_replace_termcodes("<C-\\><C-n>a<CR>", true, true, true)
      vim.api.nvim_feedkeys(keys, 'm', false)
    end
    OpenTermThen = function(keys)
      OpenTermOrNot()
      local key = vim.api.nvim_replace_termcodes(keys, true, true, true)
      vim.api.nvim_feedkeys(key, 'm', false)
    end
  end

}


-- my old open terminal command
-- map('n', '<leader>nt', '<C-w>99l<C-w>99k<C-w>o:8 split<CR>:term<CR>', { noremap = true, silent = true, desc = '[N]ew [T]erminal tile' })

-- return {
--   'akinsho/toggleterm.nvim',
--   event = 'VeryLazy',
--   version = '*',
--   opts = {
--     size = 200,
--     open_mapping = [[<leader>tt]],
--     hide_numbers = false,
--     autochdir = true,
--     persistent_size = false,
--     start_in_insert = true,
--     insert_mappings = false,  -- whether or not the open mapping applies in insert mode
--     terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
--     direction = 'vertical',
--   },
-- }
