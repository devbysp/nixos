--------------------------------------------------
-- Plugin configuration: lualine
--------------------------------------------------
local function setupLualine()
  require('lualine').setup {

    options = {
      icons_enabled = true,
      theme = 'gruvbox'
    },

    sections = {
      lualine_a = {
        { 'filename', path = 1, }
      }
    }

  }
end

local function errorHandlerForLualine(error)
  vim.notify('Lualine plugin could not be loaded!')
  vim.notify(error)
end

tryCatch(setupLualine, errorHandlerForLualine)

