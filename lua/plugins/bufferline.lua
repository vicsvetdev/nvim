-- LazyVim shows open buffers as tabs across the top. The old config had no
-- bufferline, so turn it off. showtabline is deliberately left at its default
-- of 1: no tabline for buffers, but a real one still appears if :tabnew is
-- ever used. Buffer cycling survives via LazyVim's core mappings (<S-l>, [b,
-- ]b -> bnext/bprevious); only bufferline-specific commands go away
-- (<leader>bp pin, <leader>bj pick, <leader>br/bl, [B/]B move).
return {
  { "akinsho/bufferline.nvim", enabled = false },
}
