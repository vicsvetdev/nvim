return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      install_dir = vim.fn.stdpath("data") .. "/site",
    },
    config = function(_, opts)
      local ts = require("nvim-treesitter")
      ts.setup(opts)
      local parsers = {
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
      }
      ts.install(parsers)
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          local lang = vim.treesitter.language.get_lang(ft) or ft
          local ok = pcall(vim.treesitter.language.add, lang)
          if ok then pcall(vim.treesitter.start, args.buf, lang) end
        end,
      })
    end,
  },
}
