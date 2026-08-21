return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.omnisharp = { enabled = false }
      opts.servers.fsautocomplete = { enabled = false }

      local star = opts.servers["*"] or {}
      star.keys = star.keys or {}

      star.keys = vim.tbl_filter(function(k)
        return k[1] ~= "<leader>cc"
      end, star.keys)

      table.insert(star.keys, {
        "K",
        function()
          local docs = require("noice.lsp.docs")
          local hover_msg = docs._messages and docs._messages["hover"]
          if hover_msg and hover_msg:win() then
            docs.hide(hover_msg)
            return
          end
          vim.lsp.buf.hover()
        end,
        desc = "Hover (toggles the noice window)",
      })
      opts.servers["*"] = star
    end,
  },

  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local drop = { csharpier = true, fantomas = true }
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return not drop[tool]
      end, opts.ensure_installed or {})
    end,
  },

  { "Hoffs/omnisharp-extended-lsp.nvim", enabled = false },

  {
    "seblyng/roslyn.nvim",
    opts = { filewatching = "roslyn" },
    config = function(_, opts)
      local dotnet_root = "/usr/share/dotnet"
      if vim.uv.fs_stat(dotnet_root .. "/shared/Microsoft.NETCore.App") then
        vim.lsp.config("roslyn", { cmd_env = { DOTNET_ROOT = dotnet_root } })
      end
      require("roslyn").setup(opts)
    end,
  },
}
