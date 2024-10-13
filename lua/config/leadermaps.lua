-- stylua: ignore start

-- Create global tables with information about clue groups in certain modes
-- Structure of tables is taken to be compatible with 'mini.clue'.
_G.Config.leader_group_clues = {
  { mode = 'n', keys = '<Leader>b', desc = '+Buffer' },
  { mode = 'n', keys = '<Leader>e', desc = '+Explore' },
  { mode = 'n', keys = '<Leader>f', desc = '+Find' },
  { mode = 'n', keys = '<Leader>g', desc = '+Git' },
  { mode = 'n', keys = '<Leader>l', desc = '+LSP' },
  { mode = 'n', keys = '<Leader>m', desc = '+Map' },
  { mode = 'n', keys = '<Leader>o', desc = '+Other' },
  { mode = 'n', keys = '<Leader>t', desc = '+Terminal/Minitest' },
  { mode = 'n', keys = '<Leader>T', desc = '+Test' },
  { mode = 'n', keys = '<Leader>v', desc = '+Visits' },
  { mode = 'n', keys = '<Leader>s', desc = '+Spectre' },
  { mode = 'x', keys = '<Leader>l', desc = '+LSP' },
}

-- Create `<Leader>` mappings
local nmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('n', '<Leader>' .. suffix, rhs, opts)
end
local xmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('x', '<Leader>' .. suffix, rhs, opts)
end
local vmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set('v', '<Leader>' .. suffix, rhs, opts)
end

-- Stop highlighting of search results. NOTE: this can be done with default
-- `<C-l>` but this solution deliberately uses `:` instead of `<Cmd>` to go
-- into Command mode and back which updates 'mini.map'.
nmap_leader([[h]], ':let v:hlsearch = 1 - v:hlsearch<CR>', 'Toggle hlsearch')


-- b is for 'buffer'
nmap_leader([[ba]], '<Cmd>b#<CR>',                                 'Alternate')
nmap_leader([[bd]], '<Cmd>lua MiniBufremove.delete()<CR>',         'Delete')
nmap_leader([[bD]], '<Cmd>lua MiniBufremove.delete(0, true)<CR>',  'Delete!')
nmap_leader([[bs]], '<Cmd>lua Config.new_scratch_buffer()<CR>',    'Scratch')
nmap_leader([[bw]], '<Cmd>lua MiniBufremove.wipeout()<CR>',        'Wipeout')
nmap_leader([[bW]], '<Cmd>lua MiniBufremove.wipeout(0, true)<CR>', 'Wipeout!')

-- e is for 'explore' and 'edit'
nmap_leader([[ec]], '<Cmd>lua MiniFiles.open(vim.fn.stdpath("config"))<CR>',                                  'Config')
nmap_leader([[ed]], '<Cmd>lua MiniFiles.open()<CR>',                                                          'Directory')
nmap_leader([[ef]], '<Cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0))<CR>',                              'File directory')
nmap_leader([[eq]], '<Cmd>lua Config.toggle_quickfix()<CR>',                                                  'Quickfix')

-- f is for 'fuzzy find'
-- nmap_leader([[f/]], '<Cmd>Pick history scope="/"<CR>',                 '"/" history')
-- nmap_leader([[f:]], '<Cmd>Pick history scope=":"<CR>',                 '":" history')
-- nmap_leader([[fb]], '<Cmd>Pick buffers<CR>',                           'Buffers')
-- nmap_leader([[fc]], '<Cmd>Pick git_commits<CR>',                       'Commits (all)')
-- nmap_leader([[fC]], '<Cmd>Pick git_commits path="%"<CR>',              'Commits (current)')
-- nmap_leader([[fd]], '<Cmd>Pick diagnostic scope="all"<CR>',            'Diagnostic workspace')
-- nmap_leader([[fD]], '<Cmd>Pick diagnostic scope="current"<CR>',        'Diagnostic buffer')
-- nmap_leader([[ff]], '<Cmd>Pick files<CR>',                             'Files')
-- nmap_leader([[fg]], '<Cmd>Pick grep_live<CR>',                         'Grep live')
-- nmap_leader([[fG]], '<Cmd>Pick grep pattern="<cword>"<CR>',            'Grep current word')
-- nmap_leader([[fh]], '<Cmd>Pick help<CR>',                              'Help tags')
-- nmap_leader([[fH]], '<Cmd>Pick hl_groups<CR>',                         'Highlight groups')
-- nmap_leader([[fl]], '<Cmd>Pick buf_lines scope="all"<CR>',             'Lines (all)')
-- nmap_leader([[fL]], '<Cmd>Pick buf_lines scope="current"<CR>',         'Lines (current)')
-- nmap_leader([[fm]], '<Cmd>Pick git_hunks<CR>',                         'Modified hunks (all)')
-- nmap_leader([[fM]], '<Cmd>Pick git_hunks path="%"<CR>',                'Modified hunks (current)')
-- nmap_leader([[fr]], '<Cmd>Pick resume<CR>',                            'Resume')
-- nmap_leader([[fR]], '<Cmd>Pick lsp scope="references"<CR>',            'References (LSP)')
-- nmap_leader([[fs]], '<Cmd>Pick lsp scope="workspace_symbol"<CR>',      'Symbols workspace (LSP)')
-- nmap_leader([[fS]], '<Cmd>Pick lsp scope="document_symbol"<CR>',       'Symbols buffer (LSP)')
-- nmap_leader([[fv]], '<Cmd>Pick visit_paths cwd=""<CR>',                'Visit paths (all)')
-- nmap_leader([[fV]], '<Cmd>Pick visit_paths<CR>',                       'Visit paths (cwd)')
nmap_leader([[ft]], '<Cmd>Telescope live_grep<CR>',             'Text')
nmap_leader([[ff]], '<Cmd>Telescope find_files<CR>',            'Find files')
nmap_leader([[fb]], '<Cmd>Telescope buffers<CR>',               'Buffers')
nmap_leader([[fh]], '<Cmd>Telescope help_tags<CR>',             'Help tags')
nmap_leader([[fr]], '<Cmd>Telescope lsp_references<CR>',        'References         (LSP)')
nmap_leader([[fs]], '<Cmd>Telescope lsp_workspace_symbols<CR>', 'Symbols workspace  (LSP)')
nmap_leader([[fS]], '<Cmd>Telescope lsp_document_symbols<CR>',  'Symbols buffer     (LSP)')

-- g is for git
nmap_leader([[gc]], '<Cmd>Git commit<CR>',                      'Commit')
nmap_leader([[gC]], '<Cmd>Git commit --amend<CR>',              'Commit amend')
nmap_leader([[gg]], '<Cmd>lua Config.open_lazygit()<CR>',       'Git tab')
nmap_leader([[gl]], '<Cmd>Git log --oneline<CR>',               'Log')
nmap_leader([[gL]], '<Cmd>Git log --oneline --follow -- %<CR>', 'Log buffer')
nmap_leader([[go]], '<Cmd>lua MiniDiff.toggle_overlay()<CR>',   'Toggle overlay')
nmap_leader([[gs]], '<Cmd>lua MiniGit.show_at_cursor()<CR>',    'Show at cursor')
xmap_leader([[gs]], '<Cmd>lua MiniGit.show_at_cursor()<CR>',  'Show at selection')

-- l is for 'LSP' (Language Server Protocol)
local formatting_cmd = '<Cmd>lua require("conform").format({ lsp_fallback = true })<CR>'
nmap_leader([[la]], '<Cmd>lua vim.lsp.buf.signature_help()<CR>', 'Arguments popup')
nmap_leader([[ld]], '<Cmd>lua vim.diagnostic.open_float()<CR>',  'Diagnostics popup')
nmap_leader([[lf]], formatting_cmd,                              'Format')
nmap_leader([[li]], '<Cmd>lua vim.lsp.buf.hover()<CR>',          'Information')
nmap_leader([[lj]], '<Cmd>lua vim.diagnostic.goto_next()<CR>',   'Next diagnostic')
nmap_leader([[lk]], '<Cmd>lua vim.diagnostic.goto_prev()<CR>',   'Prev diagnostic')
nmap_leader([[lR]], '<Cmd>lua vim.lsp.buf.references()<CR>',     'References')
nmap_leader([[lr]], '<Cmd>lua vim.lsp.buf.rename()<CR>',         'Rename')
nmap_leader([[ls]], '<Cmd>lua vim.lsp.buf.definition()<CR>',     'Source definition')
xmap_leader([[lf]], formatting_cmd,                              'Format selection')

-- s is for 'Spectre' (Search & Replace)
nmap_leader([[ss]], '<Cmd>lua require("spectre").toggle()<CR>', 'Toggle Spectre')
nmap_leader([[sw]], '<Cmd>lua require("spectre").open_visual({select_word=true})<CR>', 'Search current word')
vmap_leader([[sw]], '<esc><cmd>lua require("spectre").open_visual()<CR>', 'Search current word')
nmap_leader([[sf]], '<Cmd>lua require("spectre").open_file_search()<CR>', 'Search in current file')

-- m is for 'map'
nmap_leader([[mc]], '<Cmd>lua MiniMap.close()<CR>',        'Close')
nmap_leader([[mf]], '<Cmd>lua MiniMap.toggle_focus()<CR>', 'Focus (toggle)')
nmap_leader([[mo]], '<Cmd>lua MiniMap.open()<CR>',         'Open')
nmap_leader([[mr]], '<Cmd>lua MiniMap.refresh()<CR>',      'Refresh')
nmap_leader([[ms]], '<Cmd>lua MiniMap.toggle_side()<CR>',  'Side (toggle)')
nmap_leader([[mt]], '<Cmd>lua MiniMap.toggle()<CR>',       'Toggle')

-- o is for 'other'
local trailspace_toggle_command = '<Cmd>lua vim.b.minitrailspace_disable = not vim.b.minitrailspace_disable<CR>'
nmap_leader([[oC]], '<Cmd>lua MiniCursorword.toggle()<CR>',  'Cursor word hl toggle')
nmap_leader([[od]], '<Cmd>Neogen<CR>',                       'Document')
nmap_leader([[oh]], '<Cmd>normal gxiagxila<CR>',             'Move arg left')
nmap_leader([[oH]], '<Cmd>TSBufToggle highlight<CR>',        'Highlight toggle')
nmap_leader([[ol]], '<Cmd>normal gxiagxina<CR>',             'Move arg right')
nmap_leader([[or]], '<Cmd>lua MiniMisc.resize_window()<CR>', 'Resize to default width')
nmap_leader([[os]], '<Cmd>lua MiniSessions.select()<CR>',    'Session select')
nmap_leader([[oS]], '<Cmd>lua Config.insert_section()<CR>',  'Section insert')
nmap_leader([[oz]], '<Cmd>lua MiniMisc.zoom()<CR>',          'Zoom toggle')

-- t is for 'terminal' (uses 'neoterm') and 'minitest'
nmap_leader([[ta]], '<Cmd>lua MiniTest.run()<CR>',                       'Test run all')
nmap_leader([[tf]], '<Cmd>lua MiniTest.run_file()<CR>',                  'Test run file')
nmap_leader([[tl]], '<Cmd>lua MiniTest.run_at_location()<CR>',           'Test run location')
nmap_leader([[ts]], '<Cmd>lua Config.minitest_screenshots.browse()<CR>', 'Test show screenshot')
nmap_leader([[tT]], '<Cmd>belowright Tnew<CR>',                          'Terminal (horizontal)')
nmap_leader([[tt]], '<Cmd>vertical Tnew<CR>',                            'Terminal (vertical)')

-- T is for 'test'
nmap_leader([[TF]], '<Cmd>TestFile -strategy=make | copen<CR>',    'File (quickfix)')
nmap_leader([[Tf]], '<Cmd>TestFile<CR>',                           'File')
nmap_leader([[TL]], '<Cmd>TestLast -strategy=make | copen<CR>',    'Last (quickfix)')
nmap_leader([[Tl]], '<Cmd>TestLast<CR>',                           'Last')
nmap_leader([[TN]], '<Cmd>TestNearest -strategy=make | copen<CR>', 'Nearest (quickfix)')
nmap_leader([[Tn]], '<Cmd>TestNearest<CR>',                        'Nearest')
nmap_leader([[TS]], '<Cmd>TestSuite -strategy=make | copen<CR>',   'Suite (quickfix)')
nmap_leader([[Ts]], '<Cmd>TestSuite<CR>',                          'Suite')

-- v is for 'visits'
nmap_leader([[vv]], '<Cmd>lua MiniVisits.add_label("core")<CR>',    'Add "core" label')
nmap_leader([[vV]], '<Cmd>lua MiniVisits.remove_label("core")<CR>', 'Remove "core" label')
nmap_leader([[vl]], '<Cmd>lua MiniVisits.add_label()<CR>',          'Add label')
nmap_leader([[vL]], '<Cmd>lua MiniVisits.remove_label()<CR>',       'Remove label')

local map_pick_core = function(keys, cwd, desc)
  local rhs = function()
    local sort_latest = MiniVisits.gen_sort.default({ recency_weight = 1 })
    MiniExtra.pickers.visit_paths({ cwd = cwd, filter = 'core', sort = sort_latest }, { source = { name = desc } })
  end
  nmap_leader(keys, rhs, desc)
end
map_pick_core([[vc]], '', 'Core visits (all)')
map_pick_core([[vC]], nil, 'Core visits (cwd)')
-- stylua: ignore end
