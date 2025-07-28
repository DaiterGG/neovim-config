return {
  'jake-stewart/multicursor.nvim',
  event = 'BufReadPost',
  branch = '1.0',
  config = function()
    local mc = require 'multicursor-nvim'

    mc.setup()

    local set = vim.keymap.set

    local c_c = vim.api.nvim_replace_termcodes('<C-c>', true, true, true)

    vim.keymap.set('n', '<esc>', function()
      vim.cmd 'nohlsearch'
      vim.api.nvim_feedkeys(c_c, 'm', false)
      mc.clearCursors()
    end, opts)

    -- Add or skip cursor above/below the main cursor.
    set({ 'n', 'x' }, '<A-v>', function()
      mc.lineAddCursor(1)
    end)
    set({ 'n', 'x' }, '<A-V>', function()
      mc.lineAddCursor(-1)
    end)
    set({ 'n', 'x' }, '<A-s>', function()
      mc.lineSkipCursor(1)
    end)
    set({ 'n', 'x' }, '<A-S>', function()
      mc.lineSkipCursor(-1)
    end)

    -- Add or skip adding anew cursor by matching word/selection
    set({ 'n', 'x' }, '<leader>vw', function()
      mc.matchAddCursor(1)
    end, { desc = 'Add cursor matching word' })
    set({ 'n', 'x' }, '<leader>vW', function()
      mc.matchAddCursor(-1)
    end, { desc = 'Add cursor matching previous word' })
    set({ 'n', 'x' }, '<leader>vs', function()
      mc.matchSkipCursor(1)
    end, { desc = 'Skip cursor matching word' })
    set({ 'n', 'x' }, '<leader>vS', function()
      mc.matchSkipCursor(-1)
    end, { desc = 'Skip cursor matching previous word' })

    -- In normal/visual mode, press `mwap` will create a cursor in every match of
    -- the word captured by `iw` (or visually selected range) inside the bigger
    -- range specified by `ap`. Useful to replace a word inside a function, e.g. mwif.
    -- set({ 'n', 'x' }, 'mw', function()
    --   mc.operator { motion = 'iw', visual = true }
    --   -- Or you can pass a pattern, press `mwi{` will select every \w,
    --   -- basically every char in a `{ a, b, c, d }`.
    --   -- mc.operator({ pattern = [[\<\w]] })
    -- end)

    -- Press `mWi"ap` will create a cursor in every match of string captured by `i"` inside range `ap`.
    -- set('n', 'mW', mc.operator)

    -- Add all matches in the document
    set({ 'n', 'x' }, '<leader>va', mc.matchAllAddCursors, { desc = 'Add all matches' })

    -- You can also add cursors with any motion you prefer:
    -- set("n", "<right>", function()
    --     mc.addCursor("w")
    -- end)
    -- set("n", "<leader><right>", function()
    --     mc.skipCursor("w")
    -- end)

    -- Rotate the main cursor.
    set({ 'n', 'x' }, '<leader>vv', mc.nextCursor, { desc = 'Next cursor' })
    set({ 'n', 'x' }, '<leader>vV', mc.prevCursor, { desc = 'Previous cursor' })

    -- Delete the main cursor.
    set({ 'n', 'x' }, '<leader>vx', mc.deleteCursor, { desc = 'Delete cursor' })

    -- Add and remove cursors with control + left click.
    -- set('n', '<c-leftmouse>', mc.handleMouse)
    -- set('n', '<c-leftdrag>', mc.handleMouseDrag)
    -- set('n', '<c-leftrelease>', mc.handleMouseRelease)

    -- Easy way to add and remove cursors using the main cursor.
    -- set({ 'n', 'x' }, '<c-q>', mc.toggleCursor)

    -- Clone every cursor and disable the originals.
    -- set({ 'n', 'x' }, '<leader><c-q>', mc.duplicateCursors)

    -- set('n', '<c-c>', function()
    --   if not mc.cursorsEnabled() then
    --     mc.enableCursors()
    --   elseif mc.hasCursors() then
    --     mc.clearCursors()
    --   else
    --     -- Default <esc> handler.
    --   end
    -- end)

    -- bring back cursors if you accidentally clear them
    set('n', '<leader>vr', mc.restoreCursors, { desc = 'Restore cursors' })

    -- Align cursor columns.
    set({ 'n', 'x' }, '<leader>vl', mc.alignCursors, { desc = 'Align cursors' })

    -- Split visual selections by regex.
    -- set('x', 'S', mc.splitCursors)

    -- Append/insert for each line of visual selections.
    -- set('x', 'I', mc.insertVisual)
    -- set('x', 'A', mc.appendVisual)

    -- match new cursors within visual selections by regex.
    -- set('x', 'M', mc.matchCursors)

    -- Rotate visual selection contents.
    -- set('x', '<leader>t', function()
    --   mc.transposeCursors(1)
    -- end)
    -- set('x', '<leader>T', function()
    --   mc.transposeCursors(-1)
    -- end)

    -- Jumplist support
    -- set({ 'x', 'n' }, '<c-i>', mc.jumpForward)
    -- set({ 'x', 'n' }, '<c-o>', mc.jumpBackward)

    -- Customize how cursors look.
    local hl = vim.api.nvim_set_hl
    hl(0, 'MultiCursorCursor', { link = 'Cursor' })
    hl(0, 'MultiCursorVisual', { link = 'Visual' })
    hl(0, 'MultiCursorSign', { link = 'SignColumn' })
    hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
    hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
    hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
  end,
}
