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
      path_display = {
        truncate = 3,
      },
      dynamic_preview_title = true,
      preview = {
        filesize_limit = 1,
        tmeout = 100,
        treesitter = true,
      },
      layout_config = {
        height = 0.95,
        width = 0.95,
        prompt_position = "top",
        preview_width = 0.5,
      },
    },
  },
}
