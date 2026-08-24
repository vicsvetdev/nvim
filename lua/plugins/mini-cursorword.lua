return {
  "nvim-mini/mini.cursorword",
  event = "VeryLazy",
  opts = {},
  init = function()
    local function highlight()
      local comment = vim.api.nvim_get_hl(0, { name = "Comment", link = false })
      local sp = comment and comment.fg or nil
      vim.api.nvim_set_hl(0, "MiniCursorword", { underline = true, sp = sp })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { underline = true, sp = sp })
    end

    highlight()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = highlight })
  end,
}
