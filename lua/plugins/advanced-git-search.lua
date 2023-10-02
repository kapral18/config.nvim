return {
  {
    "aaronhallaert/advanced-git-search.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          advanced_git_search = {
            -- See Config    -- fugitive or diffview
            diff_plugin = "diffview",
          },
        },
      })
      require("telescope").load_extension("advanced_git_search")
    end,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      -- to show diff splits and open commits in browser
      "tpope/vim-fugitive",
      -- to open commits in browser with fugitive
      "tpope/vim-rhubarb",
      -- optional: to replace the diff from fugitive with diffview.nvim
      -- (fugitive is still needed to open in browser)
      "sindrets/diffview.nvim", --- See dependencies
    },
    keys = {
      { "<leader>fgg", ":AdvancedGitSearch<CR>", desc = "AdvancedGitSearch", mode = { "n", "v" } },
      {
        "<leader>fgr",
        ":AdvancedGitSearch search_log_content<CR>",
        desc = "AGS Repo History Search",
        mode = { "n", "v" },
      },
      {
        "<leader>fgf",
        ":AdvancedGitSearch search_log_content_file<CR>",
        desc = "AGS File History Search",
        mode = { "n", "v" },
      },
      {
        "<leader>fgdf",
        ":AdvancedGitSearch diff_commit_file<CR>",
        desc = "AGS File vs commit",
        mode = { "n", "v" },
      },
      {
        "<leader>fgdl",
        ":AdvancedGitSearch diff_commit_line<CR>",
        desc = "AGS Line vs commit",
        mode = { "n", "v" },
      },
      {
        "<leader>fgdb",
        ":AdvancedGitSearch diff_branch_file<CR>",
        desc = "AGS Branch vs commit",
        mode = { "n", "v" },
      },
      {
        "<leader>fgre",
        ":AdvancedGitSearch checkout_reflog<CR>",
        desc = "AGS Checkout reflog",
        mode = { "n", "v" },
      },
      { "<leader>fgx", ":DiffviewClose<CR>", desc = "DiffviewClose", mode = { "n", "v" } },
    },
  },
}
