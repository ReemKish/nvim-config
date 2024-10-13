S = { "neovim/nvim-lspconfig" }

local function load_servers()
  local servers = {}
  for _, server_config_file in ipairs(vim.api.nvim_get_runtime_file('/lua/lspsettings/*.lua', true)) do
    local server_name = vim.fn.fnamemodify(server_config_file, ':t:r')
    servers[server_name] = dofile(server_config_file)
  end
  return servers
end

S.config = function()
  local lspconfig = require('lspconfig')
  local servers = load_servers()

  -- Preconfiguration ===========================================================
  local on_attach_custom = function(client, bufnr)
    vim.bo[bufnr].omnifunc = 'v:lua.MiniCompletion.completefunc_lsp'
  end

  -- Mappings are created globally for simplicity
  local diagnostic_opts = {
    float = { border = 'double' },
    -- Show gutter sings
    signs = {
      -- With highest priority
      priority = 9999,
      -- Only for warnings and errors
      severity = { min = 'WARN', max = 'ERROR' },
    },
    -- Show virtual text only for errors
    virtual_text = { severity = { min = 'ERROR', max = 'ERROR' } },
    -- Don't update diagnostics when typing
    update_in_insert = false,
  }

  vim.diagnostic.config(diagnostic_opts)


  for server, config in pairs(servers) do
    local on_attach = config.on_attach
    local extended_on_attach = function(client, bufnr)
      on_attach_custom(client, bufnr)
      if on_attach then on_attach(client, bufnr) end
    end

    config.on_attach = extended_on_attach

    if server == "lua_ls" then
      require('lazydev').setup({
        library = {
          -- See the configuration section for more details
          -- Load luvit types when the `vim.uv` word is found
          { path = "luvit-meta/library", words = { "vim%.uv" } },
        }
      })
    end

    lspconfig[server].setup(config)
  end
end

return S
