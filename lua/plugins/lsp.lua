-- This machine has the .NET runtime but no SDK (`dotnet --list-sdks` is empty),
-- so every `dotnet tool install` fails with exit 155. It also has no Go
-- toolchain. Both facts drive the exclusions below; re-enable the relevant
-- lines if you install the .NET SDK or Go.
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}

      -- lang.dotnet wires up dap/neotest/mason/treesitter for C#, but
      -- configures omnisharp as the LSP. roslyn.nvim supersedes it.
      opts.servers.omnisharp = { enabled = false }

      -- F# LSP, also from lang.dotnet. Needs the .NET SDK, and no F# here.
      -- `enabled = false` also keeps mason-lspconfig from trying to install it.
      opts.servers.fsautocomplete = { enabled = false }

      -- LazyVim binds K to vim.lsp.buf.hover as a buffer-local LSP keymap, so
      -- a global mapping in config/keymaps.lua would lose in any buffer with
      -- an LSP attached. Append to the shared keys instead so the noice hover
      -- toggle wins. Appended (not assigned) to keep LazyVim's other keys.
      local star = opts.servers["*"] or {}
      star.keys = star.keys or {}

      -- LazyVim binds <leader>cc buffer-locally to Run Codelens on any server
      -- advertising codeLens (vtsls does), which would beat the global
      -- <leader>cc format mapping in config/keymaps.lua. Drop it so formatting
      -- behaves the same in every buffer. <leader>cC still refreshes codelens.
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
    -- csharpier and fantomas are dotnet tools pulled in by lang.dotnet; both
    -- fail to install without the SDK and retry noisily on every launch.
    -- The old config had no C# formatter anyway.
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local drop = { csharpier = true, fantomas = true }
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return not drop[tool]
      end, opts.ensure_installed or {})
    end,
  },

  -- Only used by lang.dotnet's omnisharp definition handler.
  { "Hoffs/omnisharp-extended-lsp.nvim", enabled = false },

  { "seblyng/roslyn.nvim", opts = { filewatching = "roslyn" } },
}
