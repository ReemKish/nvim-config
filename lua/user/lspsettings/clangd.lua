return {
  cmd = {
    vim.fn.stdpath "data" .. "/mason/bin/clangd",
    "--offset-encoding=utf-16",
  },
}
