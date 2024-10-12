local miniai = require('mini.ai')
miniai.setup({
  n_lines = 500,
  custom_textobjects = {
    o = miniai.gen_spec.treesitter({ -- code block
      a = { "@block.outer", "@conditional.outer", "@loop.outer" },
      i = { "@block.inner", "@conditional.inner", "@loop.inner" },
    }),
    f = miniai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }), -- function
    c = miniai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }), -- class
    u = miniai.gen_spec.function_call(), -- u for "Usage"
    U = miniai.gen_spec.function_call({ name_pattern = "[%w_]" }), -- without dot in function name
  },
  silent=true
})
