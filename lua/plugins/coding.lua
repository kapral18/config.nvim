return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      filetypes = {
        ["*"] = true,
      },
    },
  },
  -- Easily create annotations
  {
    "danymat/neogen",
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Neogen Comment",
      },
    },
    opts = { snippet_engine = "luasnip" },
  },

  -- Refactoring
  {
    "ThePrimeagen/refactoring.nvim",
    keys = {
      {
        "<leader>r",
        function()
          require("refactoring").select_refactor({})
        end,
        mode = { "n", "x" },
        remap = false,
        silent = true,
        expr = false,
        desc = "Prime Refactor",
      },
    },
    opts = {},
  },
}
