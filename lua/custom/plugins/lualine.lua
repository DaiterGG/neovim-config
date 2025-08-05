return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  init = function()
    -- disable until lualine loads
    vim.opt.laststatus = 0
  end,
  opts = function()
    -- miasma colors
    local colors = {
      bg = '#222222',
      black = '#1c1c1c',
      grey = '#666666',
      brown = '#685742',
      green_bright = '#5f875f',
      red = '#B36D43',
      green_select = '#78824B',
      orange = '#bb7744',
      golden = '#C9A554',
      white = '#D7C483',
    }

    local conditions = {
      buffer_not_empty    = function()
        return vim.fn.empty(vim.fn.expand '%:t') ~= 1
      end,
      no_git              = function()
        local filepath = vim.fn.expand '%:p:h'
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir == ""
      end,
      buffer_empty        = function()
        return vim.fn.empty(vim.fn.expand '%:t') == 1
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand '%:p:h'
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end,
    }

    -- dump object contents
    local function dump(o)
      if type(o) == 'table' then
        local s = ''
        for k, v in pairs(o) do
          if type(k) ~= 'number' then
            k = '"' .. k .. '"'
          end
          s = s .. dump(v) .. ','
        end
        return s
      else
        return tostring(o)
      end
    end
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.orange,
      i = colors.green_bright,
      v = colors.green_select,
      [''] = colors.green_select,
      V = colors.green_select,
      c = colors.brown,
      no = colors.brown,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.red,
      R = colors.red,
      Rv = colors.red,
      cv = colors.red,
      ce = colors.red,
      r = colors.golden,
      rm = colors.golden,
      ['r?'] = colors.golden,
      ['!'] = colors.brown,
      t = colors.brown,
    }
    local mode_text_color = {
      n = colors.black,
      i = colors.black,
      v = colors.black,
      [''] = colors.black,
      V = colors.black,
      c = colors.white,
      no = colors.white,
      s = colors.black,
      S = colors.black,
      [''] = colors.black,
      ic = colors.black,
      R = colors.black,
      Rv = colors.black,
      cv = colors.black,
      ce = colors.black,
      r = colors.black,
      rm = colors.black,
      ['r?'] = colors.black,
      ['!'] = colors.white,
      t = colors.white,
    }


    -- config
    local config = {
      options = {
        -- remove default sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
          -- setting defaults to statusline
          normal = { c = { fg = colors.fg, bg = colors.bg } },
          inactive = { c = { fg = colors.fg, bg = colors.bg } },
        },
      },
      sections = {
        -- clear defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- clear for later use
        lualine_c = {},
        lualine_x = {},
      },
      inactive_sections = {
        -- clear defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- clear for later use
        lualine_c = {},
        lualine_x = {},
      },
    }

    -- insert active component in lualine_c at left section
    local function active_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- insert active component in lualine_x at right section
    local function active_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    -- active right section
    active_right {
      function()
        local tab_count = vim.fn.tabpagenr('$')
        return (tab_count == 1) and "" or ('tabs: ' .. tab_count)
      end,
      icon = '󰓪',
      color = { bg = colors.green_bright, fg = colors.black },
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░', left = '░▒▓' },
    }

    active_right {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      symbols = { error = ' ', warn = ' ', info = ' ' },
      colored = false,
      color = { bg = colors.red, fg = colors.black },
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░', left = '░▒▓' },
    }
    active_right {
      'searchcount',
      icon = '',
      color = { bg = colors.golden, fg = colors.black },

      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░', left = '░▒▓' },
    }

    active_right {
      function()
        local clients = vim.lsp.get_clients()
        local clients_list = {}
        for _, client in pairs(clients) do
          if not clients_list[client.name] then
            table.insert(clients_list, client.name)
          end
        end
        local lsp_lbl = dump(clients_list):gsub('(.*),', '%1')
        local res = lsp_lbl:gsub(',', ', ')
        active_sections[1] = res ~= ""
        return res
      end,
      icon = '󰒓',
      color = { bg = colors.green_bright, fg = colors.black },
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░', left = '░▒▓' },
    }
    active_right {
      function()
        local res = 'llm on:'
        local some = require('codeium.virtual_text').status_string()
        if some == ' 0 ' then
          res = res .. ' 0'
        else
          res = res .. some
        end
        if not WindIsOn then
          res = 'llm off'
        end
        return res
      end,
      icon = '',
      color = { bg = colors.green_select, fg = colors.black },
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░', left = '░▒▓' },
    }

    active_right {
      function()
        local res
        if AutoEnable then
          res = 'off'
        else
          res = 'on'
        end
        return 'cmp ' .. res
      end,
      icon = '',
      color = { bg = colors.green_bright, fg = colors.black },
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░', left = '░▒▓' },
    }
    active_right {
      'location',
      icon = '',
      color = { bg = colors.green_select, fg = colors.black },
      padding = { left = 1, right = 0 },
      separator = { left = '░▒▓' },
    }
    active_right {
      function()
        local cur = vim.fn.line '.'
        local total = vim.fn.line '$'
        return string.format('%2d%%%%', math.floor(cur / total * 100))
      end,
      color = { bg = colors.green_select, fg = colors.black },
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░' },
    }
    active_right {
      'o:encoding',
      fmt = string.upper,
      icon = '',
      padding = { left = 1, right = 1 },
      color = { bg = colors.orange, fg = colors.black },
    }
    active_right {
      'fileformat',
      fmt = string.lower,
      icons_enabled = true,
      color = { bg = colors.orange, fg = colors.black },
      separator = { right = '' },
      padding = { left = 0, right = 1 },
    }

    -- active left section
    active_left {
      function()
        local icon
        local ok, devicons = pcall(require, 'nvim-web-devicons')
        if ok then
          icon = devicons.get_icon(vim.fn.expand '%:t')
          if icon == nil then
            icon = devicons.get_icon_by_filetype(vim.bo.filetype)
          end
        else
          if vim.fn.exists '*WebDevIconsGetFileTypeSymbol' > 0 then
            icon = vim.fn.WebDevIconsGetFileTypeSymbol()
          end
        end
        if icon == nil then
          icon = ''
        end
        return icon:gsub('%s+', '')
      end,
      color = function()
        return { bg = mode_color[vim.fn.mode()], fg = mode_text_color[vim.fn.mode()] }
      end,
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░' },
    }
    active_left {
      'filename',
      cond = conditions.buffer_not_empty,
      color = function()
        return { bg = mode_color[vim.fn.mode()], fg = mode_text_color[vim.fn.mode()] }
      end,
      padding = { left = 0, right = 1 },
      separator = { right = '▓▒░' },
      symbols = {
        modified = '󰶻 ',
        readonly = ' ',
        unnamed = ' ',
        newfile = ' ',
      },
    }
    active_left {
      function()
        return 'welcome.nvim'
      end,
      cond = conditions.buffer_empty,
      color = function()
        return { bg = mode_color[vim.fn.mode()], fg = mode_text_color[vim.fn.mode()] }
      end,
      padding = { left = 0, right = 1 },
      separator = { right = '▓▒░' },
    }
    active_left {
      'branch',
      color = { bg = colors.green_select, fg = colors.black },
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░', left = '░▒▓' },
    }

    active_left {
      function()
        return "none"
      end,
      cond = conditions.no_git,
      icon = "",
      color = { bg = colors.green_select, fg = colors.black },
      padding = { left = 1, right = 1 },
      separator = { right = '▓▒░', left = '░▒▓' },
    }

    return config
  end,
}
