return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "tsakirist/telescope-lazy.nvim" },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
    },
  },
  keys = {
    { "<leader>gb", ":Telescope git_branches<CR>", desc = "Branches" },
    { "<leader>gC", ":Telescope git_bcommits<CR>", desc = "Buffer Commits" },
    { "<leader>sg", false },
    { "<leader>sG", false },
    { "<leader>ff", false },
    { "<leader>fF", false },
    { "<leader>/", ":Telescope live_grep_args<CR>", desc = "Live Grep" },
    {
      "<leader><space>",
      function()
        local telescope_builtin = require("telescope.builtin")
        telescope_builtin["find_files"]({ no_ignore = true, hidden = true, default_text = "" })
      end,
      desc = "Find Files",
    },
    {
      "<leader>sw",
      function()
        require("telescope-live-grep-args.shortcuts").grep_word_under_cursor()
      end,
      desc = "Live Grep <cWORD>",
    },
    {
      "<leader>sw",
      function()
        require("telescope-live-grep-args.shortcuts").grep_visual_selection()
      end,
      mode = "v",
      desc = "Live Grep Selection",
    },
    { "<leader>sW", false, mode = { "v", "n" } },
  },
  opts = function(_, opts)
    ---@param pattern string
    ---@return string escaped pattern
    local function escape_pattern(pattern)
      local escaped_pattern = pattern:gsub("[%-%.%+%[%]%(%)%$%^%%%?%*]", "%%%1")
      return escaped_pattern
    end

    ---@param postfix string[]
    local toggle_prompt_postfix = function(postfix)
      local action_state = require("telescope.actions.state")
      local picker = action_state.get_current_picker(vim.fn.bufnr())
      local prompt = picker:_get_prompt()

      for _, pfix in ipairs(postfix) do
        local escaped_pfix = escape_pattern(pfix)
        -- if prompt contains pfix anywhere (with optional leading space), remove it
        if prompt:find("%s*" .. escaped_pfix) then
          prompt = prompt:gsub("%s*" .. escaped_pfix, "")
        else
          prompt = prompt .. " " .. pfix
        end
      end

      picker:set_prompt(prompt)
    end

    local defaults = {
      hidden = true,
      no_ignore = true,
    }

    local toggle_no_ignore = (function()
      local no_ignore = defaults.no_ignore

      return function()
        local telescope_builtin = require("telescope.builtin")
        local action_state = require("telescope.actions.state")
        local picker = action_state.get_current_picker(vim.fn.bufnr())
        local prompt = picker:_get_prompt()
        if picker.prompt_title == "Find Files" then
          local is_ignored = not no_ignore
          telescope_builtin["find_files"]({
            no_ignore = is_ignored,
            hidden = defaults.hidden,
            default_text = prompt,
          })
          no_ignore = is_ignored
        end

        if picker.prompt_title == "Live Grep (Args)" then
          toggle_prompt_postfix({ "--no-ignore" })
        end
      end
    end)()

    local toggle_hidden = (function()
      local hidden = true
      return function()
        local telescope_builtin = require("telescope.builtin")
        local action_state = require("telescope.actions.state")
        local picker = action_state.get_current_picker(vim.fn.bufnr())
        local prompt = picker:_get_prompt()
        if picker.prompt_title == "Find Files" then
          local is_hidden = not hidden
          telescope_builtin["find_files"]({
            hidden = is_hidden,
            no_ignore = defaults.no_ignore,
            default_text = prompt,
          })
          hidden = is_hidden
        end

        if picker.prompt_title == "Live Grep (Args)" then
          toggle_prompt_postfix({ "--hidden" })
        end
      end
    end)()

    local toggle_no_ignore_hidden = (function()
      local no_ignore = defaults.no_ignore
      local hidden = defaults.hidden
      return function()
        local telescope_builtin = require("telescope.builtin")
        local action_state = require("telescope.actions.state")
        local picker = action_state.get_current_picker(vim.fn.bufnr())
        local prompt = picker:_get_prompt()
        if picker.prompt_title == "Find Files" then
          local is_ignored = not no_ignore
          local is_hidden = not hidden
          telescope_builtin["find_files"]({
            no_ignore = is_ignored,
            hidden = is_hidden,
            default_text = prompt,
          })
          no_ignore = is_ignored
          hidden = is_hidden
        end
        if picker.prompt_title == "Live Grep (Args)" then
          toggle_prompt_postfix({ "--no-ignore", "--hidden" })
        end
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
          ["<a-i>"] = toggle_no_ignore,
          ["<a-h>"] = toggle_hidden,
          ["<a-a>"] = toggle_no_ignore_hidden,
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
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("live_grep_args")
    telescope.load_extension("fzf")
  end,
}
