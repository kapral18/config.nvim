return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "vale",
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        ["markdown"] = { "vale" },
        ["markdown.mdx"] = { "vale" },
      },
    },
  },
}
