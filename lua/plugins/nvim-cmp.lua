M = {
  "hrsh7th/nvim-cmp",
  version = false, -- last release is way too old
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip',
    'rafamadriz/friendly-snippets',
  }
}


M.config = function()
  vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
  local cmp = require'cmp'
  local luasnip = require'luasnip'

  local select_next_item = function() cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }) end
  local select_prev_item = function() cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }) end
  local scroll_docs = cmp.mapping.scroll_docs
  local abort = function(fallback) cmp.abort() fallback() end

  local confirm_completion_or_expand_snippet = cmp.mapping(
    function(fallback)
      if cmp.visible() then
        if luasnip.expandable() then
          luasnip.expand()
        else
          cmp.confirm({ select = true })
        end
      else
        fallback()
      end
    end
  )

  local next_completion_or_snippet_node = cmp.mapping(
    function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end,
    { "i", "s" }
  )

  local prev_completion_or_snippet_node = cmp.mapping(
    function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
    { "i", "s" }
  )

  cmp.setup({
    snippet = {
      expand = function(args) luasnip.lsp_expand(args.body) end,
    },
    completion = {
      completeopt = "menu,menuone,noinsert,fuzzy,noselect",
    },
    preselect = cmp.PreselectMode.Item,
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"]   = scroll_docs(-4),
      ["<C-f>"]   = scroll_docs(4),
      ["<C-n>"]   = select_next_item,
      ["<C-p>"]   = select_prev_item,
      ["<C-CR>"]  = abort,
      ['<CR>']    = confirm_completion_or_expand_snippet,
      ["<Tab>"]   = next_completion_or_snippet_node,
      ["<S-Tab>"] = prev_completion_or_snippet_node,
    }),
    sources = cmp.config.sources({
      { name = "path" },
      { name = "nvim_lsp" },
      { name = "luasnip", keyword_length = 2 },
      { name = "lazydev", group_index = 0 },
    }, {
      { name = "buffer" },
    }),
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    formatting = {
      expandable_indicator = true,
      fields = { "abbr", "kind" },
      format = function(entry, item)
        item.kind = MiniIcons.get('lsp', item.kind) .. ' ' .. item.kind

        local widths = {
          abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
          menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
        }

        for key, width in pairs(widths) do
          if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
            item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
          end
        end

        return item
      end,
    },
    experimental = {
      ghost_text = {
        hl_group = "CmpGhostText",
      },
    },
  })

  require('luasnip.loaders.from_vscode').lazy_load()

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })
end

return M
