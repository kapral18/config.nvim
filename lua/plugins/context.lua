return {
  {
    "folke/noice.nvim",
    opts = {
      lsp = {
        signature = {
          enabled = false,
        },
      },
    },
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").on_attach()
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      require("symbols-outline").setup()
    end,
  },
}
