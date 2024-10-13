local S1 = { "nvim-treesitter/nvim-treesitter" }

S1.config = function()
  --stylua: ignore
  local ensure_installed = {
    'bash',   'toml',   'cpp',  'css', 'python',
    'yaml',   'rust',   'vim',  'tsx', 'vimdoc',
    'json',   'html',   'lua',  'rst', 'regex',
    'javascript', 'markdown', 'markdown_inline', 'c',
  }

  require('nvim-treesitter.configs').setup({
    ensure_installed = ensure_installed,
    highlight = { enable = true },
    incremental_selection = { enable = false },
    textobjects = { enable = false },
    indent = { enable = false },
  })

  -- Disable injections in 'lua' language.
  local ts_query = require('vim.treesitter.query')
  ts_query.set('lua', 'injections', '')
end


local S2 = {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = {S1}
}

S2.config = function() end

return {S1, S2}
