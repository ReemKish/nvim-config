-- Lua (lua-language-server) ==================================================
M = {}

local lspconfig = require'lspconfig'

M.on_init = function(client)
  if client.workspace_folders then
    local path = client.workspace_folders[1].name
    if vim.uv.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
      return
    end
  end
end

M.on_attach = function(client, _)
  -- Reduce unnecessarily long list of completion triggers for better
  -- `MiniCompletion` experience
  client.server_capabilities.completionProvider.triggerCharacters = { '.', ':' }
end

M.root_dir = function(fname)
  return lspconfig.util.root_pattern('.git')(fname) or lspconfig.util.path.dirname(fname)
end

M.settings = {
  Lua = {
    runtime = {
      -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
      version = 'LuaJIT',
      -- Setup your lua path
      path = vim.split(package.path, ';'),
    },
    diagnostics = {
      -- Get the language server to recognize common globals
      globals = { 'vim' },
      disable = { 'need-check-nil' },
      -- Don't make workspace diagnostic, as it consumes too much CPU and RAM
      workspaceDelay = -1,
    },
    workspace = {
      -- Don't analyze code from submodules
      ignoreSubmodules = true,
      library = {
        vim.fn.expand '$VIMRUNTIME/lua',
        vim.fn.stdpath 'config' .. '/lua',
      }
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
      enable = false,
    },
  },
}

return M
