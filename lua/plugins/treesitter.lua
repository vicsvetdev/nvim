return {
  {
    "romus204/tree-sitter-manager.nvim",
    lazy = false,
    opts = {
      ensure_installed = {
        "c_sharp",
        "rust",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "typescript",
        "tsx",
        "rego",
        "terraform",
        "hcl",
      },
      auto_install = false,
      highlight = false,
    },
    config = function(_, opts)
      require("tree-sitter-manager").setup(opts)
      vim.treesitter.language.register("terraform", "tf")

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args) pcall(vim.treesitter.start, args.buf) end,
      })
    end,
  },
}
