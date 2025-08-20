return {
  'rebelot/terminal.nvim',
  event = 'VeryLazy',
  config = function()
    local map = vim.keymap.set
    local cmd = vim.api.nvim_create_autocmd

    require("terminal").setup(
      {
        autoclose = true,
        layout = {
          open_cmd = "float",
          -- border = "rounded",
          height = 0.97,
          width = 1.0
        }
      })

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

    -- toggle fn for kemap
    local toggle_term = function()
      local tab_id = vim.api.nvim_get_current_tabpage()
      local term = TabTerm[tab_id]
      local now_is_on = not term.is_on
      term.is_on = now_is_on
      if not now_is_on then
        require("terminal").close()
        return
      end

      if term.id == nil then
        require("terminal").run('')
        term.id = require("terminal").current_term_index()
      else
        require("terminal").open(term.id)
      end

      local keys = vim.api.nvim_replace_termcodes("a", true, true, true)
      vim.api.nvim_feedkeys(keys, 'm', false)
    end
    map('n', '<A-n>', toggle_term, { noremap = true, silent = true, desc = '[T]oggle [T]erminal' })
    -- map('t', '<leader>tt', toggle_term, { noremap = true, silent = true, desc = '[T]oggle [T]erminal' })
    map('t', '<A-n>', toggle_term, { noremap = true, silent = true, desc = '[T]oggle [T]erminal' })

    map('t', '<A-;>', '<C-\\><C-n>:', { noremap = true, silent = true })

    -- NOTE: Select Current Directory
    vim.keymap.set('n', '<leader>cd', function()
      local tab_id = vim.api.nvim_get_current_tabpage()
      local term = TabTerm[tab_id]
      if term.is_on then
        local cwd = vim.fn.getcwd()
        OpenTermThen('cd /d "' .. cwd .. '"<cr>')
      else
        vim.cmd 'cd %:p:h'
        vim.cmd 'cd'
      end
    end, { desc = '[C]urrent [D]irectory' })

    map('t', '<A-c><A-d>', function()
      local cwd = vim.fn.getcwd()
      OpenTermThen('cd /d "' .. cwd .. '"<cr>')
    end, { noremap = true, silent = true })

    -- NOTE: new tab with terminal
    vim.api.nvim_create_user_command("TTerm", function()
      vim.cmd("tabnew")
      vim.cmd("terminal")
    end, {})
    vim.api.nvim_create_user_command("TTerm2", function()
      vim.cmd("tabnew")
      vim.cmd("terminal")
      vim.cmd("split")
      vim.cmd("terminal")
    end, {})
    vim.api.nvim_create_user_command("TTerm3", function()
      vim.cmd("tabnew")
      vim.cmd("terminal")
      vim.cmd("split")
      vim.cmd("terminal")
      vim.cmd("vsplit")
      vim.cmd("terminal")
    end, {})
    vim.api.nvim_create_user_command("TTerm4", function()
      vim.cmd("tabnew")
      vim.cmd("terminal")
      vim.cmd("split")
      vim.cmd("terminal")
      vim.cmd("vsplit")
      vim.cmd("terminal")

      local keys = vim.api.nvim_replace_termcodes("<C-w>k:vsplit<cr>:terminal<cr>", true, true, true)
      vim.api.nvim_feedkeys(keys, 'm', false)
    end, {})

    -- NOTE: Go Back
    vim.keymap.set('t', '<A-b>', function()
      OpenTermThen('cd ..<cr>')
    end, { desc = 'cd [B]ack' })

    vim.keymap.set('n', '<leader>b', function()
      local tab_id = vim.api.nvim_get_current_tabpage()
      local term = TabTerm[tab_id]
      if term.is_on then
        OpenTermThen('cd ..<cr>')
      else
        vim.cmd 'cd ..'
        vim.cmd 'cd'
      end
    end, { desc = 'cd [B]ack' })

    -- open if needed and focus terminal
    OpenTermOrNot = function()
      local tab_id = vim.api.nvim_get_current_tabpage()
      local term = TabTerm[tab_id]
      local already_on = term.is_on
      if not already_on then
        term.is_on = true
        local term_id = term.id
        if term_id == nil then
          require("terminal").run('')
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
