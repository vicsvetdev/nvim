return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    config = function()
      local fzf = require("fzf-lua")
      fzf.setup({
        grep = {
          rg_glob = true,
        },
      })
      fzf.register_ui_select()
    end,
  },
}
