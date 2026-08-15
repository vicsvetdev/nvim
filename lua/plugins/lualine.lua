-- Match the old mini.statusline layout: mode | diagnostics | path  ...  line|total
return {
  "nvim-lualine/lualine.nvim",
  opts = function(_, opts)
    opts.sections = {
      lualine_a = { "mode" },
      lualine_b = { "diagnostics" },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = {},
      lualine_y = {},
      lualine_z = { "%l|%L" },
    }
  end,
}
