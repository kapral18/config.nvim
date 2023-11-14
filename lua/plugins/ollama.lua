return {
  "David-Kunz/gen.nvim",
  keys = {
    { "<leader>]", ":Gen<CR>", mode = { "n", "v", "x" }, desc = "Local AI Gen" },
  },
  config = function()
    require("gen").model = "phind-codellama:34b-v2"
  end,
}
