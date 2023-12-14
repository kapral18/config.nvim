return {
  "David-Kunz/gen.nvim",
  keys = {
    { "<leader>ola", ":Gen<CR>", mode = { "n", "v", "x" }, desc = "Local [Ol]l[a]ma: Menu" },
    {
      "<leader>olm",
      function()
        require("gen").select_model()
      end,
      mode = { "n" },
      desc = "Local [Ol]lama: [M]odel",
    },
  },
  opts = {
    model = "codebooga:16k",
    display_mode = "float",
    show_model = true,
    no_serve = true,
    debugCommand = true,
  },
}
