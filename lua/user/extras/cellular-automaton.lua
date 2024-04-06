local M = {
  "eandrju/cellular-automaton.nvim",
}

function M.config()
  local wk = require "which-key"
  wk.register {
    ["<leader>y"] = { "<cmd>CellularAutomaton make_it_rain<CR>", "Cellular Automaton" },
  }
end

return M
