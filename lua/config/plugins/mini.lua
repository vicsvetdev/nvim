return {
  {
    "nvim-mini/mini.nvim",
    version = "*",
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({
        use_icons = true,
        content = {
          active = function()
            local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
            local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
            local filename = MiniStatusline.section_filename({ trunc_width = 140 })
            return MiniStatusline.combine_groups({
              { hl = mode_hl, strings = { mode } },
              { hl = "MiniStatuslineDevinfo", strings = { diagnostics } },
              "%<",
              { hl = "MiniStatuslineFilename", strings = { filename } },
              "%=",
              { hl = mode_hl, strings = { "%l|%L" } },
            })
          end,
        },
      })

      local cursorword = require("mini.cursorword")
      cursorword.setup()

      vim.api.nvim_set_hl(0, "MiniCursorword", { bg = "#2a2836" })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { bg = "#2a2836" })

      local ai = require("mini.ai")
      ai.setup()

      require("mini.pairs").setup()
    end,
  },
}
