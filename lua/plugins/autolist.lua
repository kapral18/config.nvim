return {
  {
    "gaoDean/autolist.nvim",
    ft = {
      "markdown",
      "text",
      "tex",
      "plaintex",
      "norg",
    },
    opts = {},
    keys = {
      { "<tab>", "<cmd>AutolistTab<cr>", mode = { "i" } },
      { "<s-tab>", "<cmd>AutolistShiftTab<cr>", mode = { "i" } },
      { "<CR>", "<CR><cmd>AutolistNewBullet<cr>", mode = { "i" } },
      { "o", "o<cmd>AutolistNewBullet<cr>" },
      { "O", "O<cmd>AutolistNewBulletBefore<cr>" },
      { "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>" },
      { "<C-r>", "<cmd>AutolistRecalculate<cr>" },

      { "].", "<cmd>AutolistCycleNext<cr>", desc = "Next List Type" },
      { "[.", "<cmd>AutolistCyclePrev<cr>", desc = "Prev List Type" },

      { ">>", ">><cmd>AutolistRecalculate<cr>" },
      { "<<", "<<<cmd>AutolistRecalculate<cr>" },
      { "dd", "dd<cmd>AutolistRecalculate<cr>" },
      { "d", "d<cmd>AutolistRecalculate<cr>", mode = { "v" } },
    },
  },
}
