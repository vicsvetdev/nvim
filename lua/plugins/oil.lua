return {
  {
    "stevearc/oil.nvim",
    -- mini.icons is already provided by LazyVim, so the old dependency entry
    -- is dropped. <leader>e is bound in lua/config/keymaps.lua.
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
    lazy = false,
  },
}
