vim.filetype.add({
  extension = {
    mdx = "jsx",
  },
})

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "mdx-analyzer")
    end,
  },
}
