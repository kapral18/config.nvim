return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "antosha417/nvim-lsp-file-operations", config = true },
  },
  opts = {
    -- make sure mason installs the server
    servers = {
      yamlls = {
        settings = {
          yaml = {
            customTags = {
              "!reference sequence",
            },
          },
        },
      },
    },
  },
}
