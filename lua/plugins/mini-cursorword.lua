return {
  "nvim-mini/mini.cursorword",
  event = "VeryLazy",
  opts = {},
  config = function(_, opts)
    require("mini.cursorword").setup(opts)

    -- The old config hardcoded bg #2a2836, which was tied to the theme in use
    -- at the time and would survive Omarchy theme switches looking wrong.
    -- Linking to Visual keeps the same "subtle selection-coloured background"
    -- effect in every theme. Re-applied on ColorScheme because linked groups
    -- are cleared when a colorscheme loads.
    local function highlight()
      vim.api.nvim_set_hl(0, "MiniCursorword", { link = "Visual" })
      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { link = "Visual" })
    end

    highlight()
    vim.api.nvim_create_autocmd("ColorScheme", { callback = highlight })
  end,
}
