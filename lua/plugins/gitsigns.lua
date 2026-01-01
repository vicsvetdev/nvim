return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    })

    vim.keymap.set("n", "<leader>vp", ":Gitsigns preview_hunk<CR>", {})
    vim.keymap.set("n", "<leader>vr", ":Gitsigns reset_hunk<CR>", {})
    vim.keymap.set("n", "<leader>vb", ":Gitsigns toggle_current_line_blame<CR>", {})
  end,
}
