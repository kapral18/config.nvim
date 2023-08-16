local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  opts = {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
      },
    },
  },
  keys = {
    {
      "<leader>sg",
      Util.telescope("grep_string", {
        shorten_path = true,
        word_match = "-w",
        only_sort_text = true,
        search = "",
      }),
      desc = "Grep (project root)",
    },
  },
}
