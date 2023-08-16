local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
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
      function()
        require("telescope.builtin").grep_string({
          shorten_path = true,
          word_match = "-w",
          only_sort_text = true,
          search = "",
        })
      end,
      desc = "Grep (root dir)",
    },
    {
      "<leader>sG",
      function()
        require("telescope.builtin").grep_string({
          shorten_path = true,
          word_match = "-w",
          only_sort_text = true,
          search = "",
          cwd = false,
        })
      end,
      desc = "Grep (cwd)",
    },
  },
}
