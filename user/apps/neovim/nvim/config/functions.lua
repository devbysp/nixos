--------------------------------------------------
-- Global functions
--------------------------------------------------

local function createCommand(command)
  return function()
    vim.api.nvim_command(command)
  end
end

local function executeCommand(command)
  vim.api.nvim_command(command)
end 

local function doNothing()
end

local TRACE = vim.log.levels.TRACE
local DEBUG = vim.log.levels.DEBUG
local INFO = vim.log.levels.INFO
local WARN = vim.log.levels.WARN
local ERROR = vim.log.levels.ERROR
local OFF = vim.log.levels.OFF

local function notify(message, level, opts)
  vim.notify(message, level, opts)
end

local function try(resolve, args)
  local ok, message = pcall(resolve, args or {})

  if not ok then
    notify(message, TRACE)
  end
end

local function tryCatch(resolve, reject, args)
  local ok, message = pcall(resolve, args or {})

  if not ok then
    if reject then
      reject(message)
    else
      notify(message, TRACE)
    end
  end
end

local function setCurrentWindow(window)
  if vim.api.nvim_win_is_valid(window) then
    vim.api.nvim_set_current_win(window)
  else
    notify("Window " .. window .. " does not exist.", vim.log.levels.WARN)
  end
end

local function getCurrentWindow()
  return vim.api.nvim_get_current_win()
end

local function isWindowOpen(window_id)
  local windows = vim.api.nvim_list_wins()
  local exists = false

  for _, win in ipairs(windows) do
    if win == window_id then
      exists = true
      break
    end
  end

  return exists
end

local function dockCurrentWindowToRightSide(size)
  executeCommand('wincmd L')
  executeCommand('setlocal winfixwidth')
  executeCommand('vertical resize ' .. size)
  executeCommand('set nowrap')
end

local function dockCurrentWindowToBottom(size)
  executeCommand('wincmd J')
  executeCommand('setlocal winfixheight')
  executeCommand('resize ' .. size)
end

local function openTerminalWindow()
  executeCommand('split')
  dockCurrentWindowToBottom(10)
  executeCommand('terminal')
end
