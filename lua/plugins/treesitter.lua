-- LazyVim declares opts_extend = { "ensure_installed" }, so these are appended
-- to its parser list rather than replacing it. c_sharp, rust, typescript and
-- tsx already arrive via the lang.dotnet / lang.rust / lang.typescript extras.
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "rego",
      "terraform",
      "hcl",
    },
  },
}
