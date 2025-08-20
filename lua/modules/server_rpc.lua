-- NOTE: Open nvim in new tab of existing nvim instance, instead of opening new window
-- only one server will be opened at all time (subject to change)
local pipe_name = "\\\\.\\pipe\\nvim-server-multi-instance"

-- try to create a server
local function is_main_instance()
  local status, _ = pcall(vim.fn.serverstart, pipe_name)
  return status
end

-- Send files to server via RPC
local function client_mode()
  -- Try to connect to server
  local status, channel = pcall(vim.fn.sockconnect, "pipe", pipe_name, { rpc = true })
  if not status then
    vim.notify("Failed to connect to server: " .. pipe_name, vim.log.levels.ERROR)
    return
  end

  if vim.fn.argc() == 0 then
    -- empty neovim launch
    vim.rpcnotify(channel, "nvim_exec", "tabnew", false)
    -- specific to my config
    vim.rpcnotify(channel, "nvim_exec", "Alpha", false)
  else
    -- other args doesn't seems to break it?
    local file = vim.fn.argv(0)
    local escaped_file = vim.fn.fnameescape(file)

    -- open new tabs remotely
    vim.rpcnotify(channel, "nvim_exec", "tabedit " .. escaped_file, false)
  end

  -- Close client
  vim.schedule(function()
    vim.cmd(":try | qall! | catch | cq 0 | endtry")
  end)
end

-- Some utils for main instance
local function main_instance()
  -- NOTE: Close the server manually, to open nvim in a separate window
  vim.api.nvim_create_user_command("ServerStop", function()
    local _, closed = pcall(vim.fn.serverstop, pipe_name)
    if closed == 0 then
      vim.notify("There was no server to stop", vim.log.levels.WARN)
    else
      vim.notify("Server stopped, run :ServerStart to start again")
    end


    vim.api.nvim_create_user_command("ServerStart", function()
      if is_main_instance() then
        vim.notify("Server started again")
      else
        vim.notify("Failed, server started in some other neovim")
      end
    end, {})
  end, {})

  -- Auto-close server when last window closes
  -- Alt f4 also works, so not necessary?
  vim.api.nvim_create_autocmd("QuitPre", {
    callback = function()
      if vim.fn.tabpagenr('$') <= 1 then
        pcall(vim.fn.serverstop, pipe_name)
      end
    end
  })

  -- Focus the window when new files are added
  -- half works if you have multiple tabs in your terminal manager
  vim.api.nvim_create_autocmd("UIEnter", {
    callback = function()
      vim.cmd("checktime")
    end
  })
end

if is_main_instance() then
  main_instance()
else
  client_mode()
end
