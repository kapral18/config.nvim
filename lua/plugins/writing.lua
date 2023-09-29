return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "proselint",
        "write-good",
      })
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        nls.builtins.diagnostics.proselint,
        nls.builtins.code_actions.proselint,
        nls.builtins.diagnostics.write_good,
      })
    end,
  },
}
