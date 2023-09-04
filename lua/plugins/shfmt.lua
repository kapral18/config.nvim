return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      for i, source in ipairs(opts.sources) do
        if source == nls.builtins.formatting.shfmt then
          opts.sources[i] = nls.builtins.formatting.shfmt.with({
            extra_args = { "-i", "2", "-ci" },
          })
          break
        end
      end
    end,
  },
}
