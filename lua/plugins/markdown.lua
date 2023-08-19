vim.filetype.add({
  extension = {
    mdx = "jsx",
  },
})

return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "mdx-analyzer",
      },
    },
  },
}
