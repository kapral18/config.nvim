return {
  "johmsalas/text-case.nvim",
  keys = {
    {
      "<leader>cct",
      ":TextCaseOpenTelescope<CR>",
      desc = "Telescope Change Case",
      mode = { "n", "v" },
    },
    {
      "<leader>ccq",
      ":TextCaseOpenTelescopeQuickChange<CR>",
      desc = "Telescope Quick Change Case",
    },
    {
      "<leader>ccl",
      ":TextCaseOpenTelescopeLSPChange<CR>",
      desc = "Telescope LSP Change Case",
    },
  },
  dependencies = {
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("textcase").setup({})
    require("telescope").load_extension("textcase")
  end,
}
