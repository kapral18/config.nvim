return {
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    opts = {
      enabled = false,
    },
    config = function(_, opts)
      vim.cmd("highlight default link gitblame SpecialComment")
      require("gitblame").setup(opts)
    end,
  },
}
