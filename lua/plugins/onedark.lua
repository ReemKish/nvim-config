return {
  "navarasu/onedark.nvim",
  lazy = false,     -- make sure we load this during startup
  priority = 1000,  -- make sure to load this before all the other start plugins
  init = function() require('onedark').load() end,
  opts = { style = 'dark', transparent = true },
  enabled = false
}
