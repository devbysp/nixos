--------------------------------------------------
-- Plugin configuration: notify
--------------------------------------------------
local function setupNotifyPlugin()
  vim.notify = require('notify')
end

local function errorHandlerForNotify(error)
  notify('Notify plugin could not be loaded!', WARN)
  notify(error, ERROR)
end

tryCatch(setupNotifyPlugin, errorHandlerForNotify)

