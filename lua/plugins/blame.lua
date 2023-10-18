return {
  {
    "f-person/git-blame.nvim",
    event = "BufRead",
    cond = function()
      -- check if .git directory exists
      local path = require("lazyvim.util").root.get() .. "/.git"
      local ok, err = vim.loop.fs_stat(path)
      return ok and ok.type == "directory"
    end,
    config = function(_, opts)
      vim.cmd("highlight default link gitblame SpecialComment")
      require("gitblame").setup(opts)
    end,
  },
}
