-- Plugins LazyVim ships that the old config never had, and that nothing here
-- depends on. Kept as explicit `enabled = false` entries rather than deleted
-- so it stays obvious what was turned off and why.
return {
  -- Multi-file search/replace on <leader>sr, which config/keymaps.lua rebinds
  -- to the old single-file :%s template. Only reachable via :GrugFar as it
  -- stands. Drop the keymap override to get it back.
  { "MagicDuck/grug-far.nvim", enabled = false },

  -- Linting framework. Nothing configures it here: the resolved linters_by_ft
  -- was just `fish`.
  { "mfussenegger/nvim-lint", enabled = false },

  -- Diagnostics/quickfix list. The old workflow uses fzf-lua for this, via
  -- <leader>ge and <leader>gE. LazyVim's lualine trouble symbols are guarded
  -- by LazyVim.has("trouble.nvim"), so this is safe to turn off.
  { "folke/trouble.nvim", enabled = false },

  -- Session save/restore. Snacks' dashboard drops its "Restore Session" entry
  -- by itself when no session manager is installed.
  { "folke/persistence.nvim", enabled = false },

  -- TODO/FIXME highlighting and search.
  { "folke/todo-comments.nvim", enabled = false },
}
