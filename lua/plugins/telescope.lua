return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    { "tsakirist/telescope-lazy.nvim" },
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
      },
    },
  },
  keys = {
    { "<leader>gb", ":Telescope git_branches<CR>", desc = "branches" },
    { "<leader>gc", ":Telescope git_commits<CR>", desc = "commits" },
    { "<leader>gC", ":Telescope git_bcommits<CR>", desc = "buffer commits" },
  },
  init = function()
    vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
  end,
}
