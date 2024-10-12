M = { 'echasnovski/mini.nvim' }

M.config = function()
  for _, plugin_config in ipairs(vim.api.nvim_get_runtime_file('/lua/plugins/mini/*.lua', true)) do
    dofile(plugin_config)
  end
end

return M
