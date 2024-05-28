--------------------------------------------------
-- Plugin configuration: keymap
--------------------------------------------------

local function openFileHistoryWindow()
  local window_id = getCurrentWindow()

  executeCommand('DiffviewFileHistory')
  registerOnWindowFocusKeymapper(window_id, function(keybinding)
    keybinding('n', 'q', createCommand('DiffviewClose'))
  end)
end

local function openGitStatusWindow()
  local function openFugitveWindow()
    executeCommand('Git') -- Opens fugitive window
  end

  openFugitveWindow()
  dockCurrentWindowToRightSide(50)

  local window_id = getCurrentWindow()
  local function closeWindow()
    vim.api.nvim_win_close(window_id, false)
  end
  registerOnWindowFocusKeymapper(window_id, function(keybinding)
    keybinding('n', 'q', closeWindow)
  end)
end

local function setupFugitivePlugin()
  vim.keymap.set('n', 'gb', createCommand('Git blame'))
  vim.keymap.set('n', 'gs', openGitStatusWindow)
  vim.keymap.set('n', 'gl', createCommand('GV HEAD master'))
  vim.keymap.set('n', 'gla', createCommand('GV --all'))
  vim.keymap.set('n', 'gh', function() openFileHistoryWindow() end)
end

local function errorHandlerForFugitivePlugin(error)
  notify('Fugitive plugin could not be loaded!', WARN)
  notify(error, ERROR)
end

tryCatch(setupFugitivePlugin, errorHandlerForFugitivePlugin)
