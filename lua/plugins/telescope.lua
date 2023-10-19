local Util = require("lazyvim.util")

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        Util.on_load("telescope.nvim", function()
          require("telescope").load_extension("fzf")
        end)
      end,
    },
    { "tsakirist/telescope-lazy.nvim" },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
      config = function()
        Util.on_load("telescope.nvim", function()
          require("telescope").load_extension("live_grep_args")
        end)
      end,
    },
  },
  keys = {
    { "<leader>gb", ":Telescope git_branches<CR>", desc = "Branches" },
    { "<leader>gC", ":Telescope git_bcommits<CR>", desc = "Buffer Commits" },
    { "<leader>/", ":Telescope live_grep_args<CR>", desc = "Live Grep" },
    { "<leader>sg", false },
    { "<leader>sG", false },
    { "<leader>ff", false },
    { "<leader>fF", false },
    {
      "<leader><space>",
      function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope("find_files", { no_ignore = true, hidden = true, default_text = line })
      end,
      desc = "Find Files",
    },
  },
  opts = function(_, opts)
    local defaults = {
      hidden = true,
      no_ignore = true,
    }

    local find_files_ignore = (function()
      local no_ignore = true
      return function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope(
          "find_files",
          vim.tbl_deep_extend("force", defaults, { no_ignore = not no_ignore, default_text = line })
        )
      end
    end)()
    local find_files_not_hidden = (function()
      local hidden = true
      return function()
        local action_state = require("telescope.actions.state")
        local line = action_state.get_current_line()
        Util.telescope(
          "find_files",
          vim.tbl_deep_extend("force", defaults, { hidden = not hidden, default_text = line })
        )
      end
    end)()

    opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
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
      mappings = {
        i = {
          ["<a-i>"] = find_files_ignore,
          ["<a-h>"] = find_files_not_hidden,
        },
      },
    })

    local lga_actions = require("telescope-live-grep-args.actions")

    opts.extensions = vim.tbl_deep_extend("force", opts.extensions or {}, {
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        -- define mappings, e.g.
        mappings = { -- extend mappings
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          },
        },
        -- ... also accepts theme settings, for example:
        -- theme = "dropdown", -- use dropdown theme
        -- theme = { }, -- use own theme spec
        -- layout_config = { mirror=true }, -- mirror preview pane
      },
    })
  end,
  init = function()
    vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
  end,
}
