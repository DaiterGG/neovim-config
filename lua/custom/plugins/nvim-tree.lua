return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      help = {
        sort_by = 'desc',
      },
      view = {
        preserve_window_proportions = true,
        width = 40,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = true,
      },
      on_attach = function(bufnr)
        local function opts(desc)
          return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        local api = require 'nvim-tree.api'
        -- local leader = '<leader>t'
        local leader = ''
        -- vim.keymap.set('n', leader .. 'sc', api.tree.change_root_to_node, opts 'CD')
        -- vim.keymap.set('n', 'u', api.node.open.edit, opts 'Open: In Place')
        vim.keymap.set('n', leader .. 'K', api.node.show_info_popup, opts 'Info')
        vim.keymap.set('n', leader .. '<C-r>', api.fs.rename_sub, opts 'Rename: Omit Filename')
        -- vim.keymap.set('n', '<C-t>', api.node.open.tab, opts 'Open: New Tab')
        vim.keymap.set('n', leader .. '<C-v>', api.node.open.vertical, opts 'Open: Vertical Split')
        vim.keymap.set('n', leader .. '<C-h>', api.node.open.horizontal, opts 'Open: Horizontal Split')
        vim.keymap.set('n', leader .. 'e', api.node.navigate.parent_close, opts 'Close Directory')
        vim.keymap.set('n', leader .. 'u', function()
          api.node.open.edit()
          api.tree.close()
        end, opts 'Open')
        vim.keymap.set('n', leader .. '<Tab>', api.node.open.preview, opts 'Open Preview')
        vim.keymap.set('n', leader .. '>', api.node.navigate.sibling.next, opts 'Next Sibling')
        vim.keymap.set('n', leader .. '<', api.node.navigate.sibling.prev, opts 'Previous Sibling')
        vim.keymap.set('n', leader .. '.', api.node.run.cmd, opts 'Run Command')
        vim.keymap.set('n', leader .. 'b', api.tree.change_root_to_parent, opts '2. CD ..')
        vim.keymap.set('n', leader .. 'c', api.fs.create, opts '2. Create File Or Directory')
        -- vim.keymap.set('n', leader .. 'bd', api.marks.bulk.delete, opts 'Delete Bookmarked')
        -- vim.keymap.set('n', leader .. 'bt', api.marks.bulk.trash, opts 'Trash Bookmarked')
        -- vim.keymap.set('n', leader .. 'bmv', api.marks.bulk.move, opts 'Move Bookmarked')
        -- vim.keymap.set('n', leader .. 'B', api.tree.toggle_no_buffer_filter, opts 'Toggle Filter: No Buffer')
        vim.keymap.set('n', leader .. 'y', api.fs.copy.node, opts '1. Copy')
        -- vim.keymap.set('n', 'C', api.tree.toggle_git_clean_filter, opts 'Toggle Filter: Git Clean')
        -- vim.keymap.set('n', '[c', api.node.navigate.git.prev, opts 'Prev Git')
        -- vim.keymap.set('n', ']c', api.node.navigate.git.next, opts 'Next Git')
        vim.keymap.set('n', leader .. 'd', api.fs.remove, opts '1. Delete')
        vim.keymap.set('n', leader .. 'D', api.fs.trash, opts 'Trash')
        vim.keymap.set('n', leader .. 'U', api.tree.expand_all, opts 'Expand All')
        vim.keymap.set('n', leader .. 'R', api.fs.rename_basename, opts 'Rename: Basename')
        -- vim.keymap.set('n', ']e', api.node.navigate.diagnostics.next, opts 'Next Diagnostic')
        -- vim.keymap.set('n', '[e', api.node.navigate.diagnostics.prev, opts 'Prev Diagnostic')
        vim.keymap.set('n', leader .. 'F', api.live_filter.clear, opts 'Live Filter: Clear')
        vim.keymap.set('n', leader .. 'f', api.live_filter.start, opts 'Live Filter: Start')
        vim.keymap.set('n', leader .. '<leader>?', api.tree.toggle_help, opts 'Help')
        vim.keymap.set('n', leader .. 'gy', api.fs.copy.absolute_path, opts 'Copy Absolute Path')
        vim.keymap.set('n', leader .. 'ge', api.fs.copy.basename, opts 'Copy Basename')
        -- vim.keymap.set('n', 'H', api.tree.toggle_hidden_filter, opts 'Toggle Filter: Dotfiles')
        -- vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts 'Toggle Filter: Git Ignore')
        -- vim.keymap.set('n', leader .. '<c-H>', api.node.navigate.sibling.last, opts 'Last Sibling')
        -- vim.keymap.set('n', leader .. '<c-T>', api.node.navigate.sibling.first, opts 'First Sibling')
        -- vim.keymap.set('n', 'L', api.node.open.toggle_group_empty, opts 'Toggle Group Empty')
        -- vim.keymap.set('n', 'M', api.tree.toggle_no_bookmark_filter, opts 'Toggle Filter: No Bookmark')
        vim.keymap.set('n', leader .. 'm', api.marks.toggle, opts 'Toggle Bookmark')
        vim.keymap.set('n', 'o', api.node.open.edit, opts '2. Open')
        -- vim.keymap.set('n', 'O', api.node.open.no_window_picker, opts 'Open: No Window Picker')
        vim.keymap.set('n', 'O', api.tree.change_root_to_node, opts '2. CD current node')
        vim.keymap.set('n', leader .. 'p', api.fs.paste, opts '1. Paste')
        vim.keymap.set('n', leader .. 'q', api.tree.close, opts 'Close')
        vim.keymap.set('n', leader .. '<C-c>', api.tree.close, opts 'Close')
        vim.keymap.set('n', leader .. 'r', api.fs.rename, opts '1. Rename')
        vim.keymap.set('n', leader .. 'R', api.tree.reload, opts 'Refresh')
        -- vim.keymap.set('n', 's', api.node.run.system, opts 'Run System')
        -- realy bad search
        -- vim.keymap.set('n', 's', api.tree.search_node, opts 'Search')
        -- vim.keymap.set('n', 'u', api.fs.rename_full, opts 'Rename: Full Path')
        -- vim.keymap.set('n', 'U', api.tree.toggle_custom_filter, opts 'Toggle Filter: Hidden')
        vim.keymap.set('n', leader .. 'E', api.tree.collapse_all, opts 'Collapse')
        vim.keymap.set('n', leader .. 'x', api.fs.cut, opts 'Cut')
        vim.keymap.set('n', leader .. 'Y', api.fs.copy.filename, opts 'Copy Name')
        -- vim.keymap.set('n', 'Y', api.fs.copy.relative_path, opts 'Copy Relative Path')
        -- vim.keymap.set('n', '<2-LeftMouse>', api.node.open.edit, opts 'Open')
      end,
    }
  end,
}
