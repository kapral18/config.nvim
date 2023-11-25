return {
  "David-Kunz/gen.nvim",
  keys = {
    { "<leader>ai", ":Gen<CR>", mode = { "n", "v", "x" }, desc = "Local [AI]: Menu" },
    {
      "<leader>am",
      function()
        require("gen").select_model()
      end,
      mode = { "n" },
      desc = "Local [AI]: Model",
    },
  },
  opts = {
    model = "deepseek-coder:33b-instruct-q6_K",
    display_mode = "float",
    show_model = true,
    no_serve = true,
    debugCommand = true,
  },
}
