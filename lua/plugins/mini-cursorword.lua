return {
  "nvim-mini/mini.cursorword",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    require("mini.cursorword").setup(opts)

    local function highlight()
      vim.api.nvim_set_hl(0, "MiniCursorword", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "Visual" })
    end

    highlight()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = highlight })
  end,
}
