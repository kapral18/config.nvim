---@diagnostic disable: missing-fields
local M = {}

M.win_presets = {
  small = {
    no_preview = {
      height = 0.35,
      width = 0.65,
      preview = {
        hidden = "hidden",
      },
    },
  },
  medium = {
    flex = {
      height = 0.75,
      width = 0.75,
      preview = {
        layout = "flex",
      },
    },
    vertical = {
      height = 0.75,
      width = 0.75,
      preview = {
        layout = "vertical",
        vertical = "up:65%",
      },
    },
  },
  large = {
    vertical = {
      height = 0.9,
      width = 0.9,
      preview = {
        layout = "vertical",
        vertical = "up:65%",
      },
    },
  },
  full = {
    vertical = {
      fullscreen = true,
      preview = {
        layout = "vertical",
        vertical = "down:75%",
      },
    },
  },
}

local rg_ignore_glob =
  "-g '!{node_modules,.next,dist,build,reports,.idea,.vscode,.yarn,.nyc_output,__generated__,reports,storybook-static}/' -g '!{*.min.js,*.min.css,junit.xml}'"
local fd_ignore_glob =
  "-E '{node_modules,.next,dist,build,reports,.idea,.vscode,.yarn,.nyc_output,__generated__,reports,storybook-static}/' -E '{*.min.js,*.min.css,junit.xml}'"

M.rg_opts_unrestricted =
  "--column --line-number --no-heading --color=always --smart-case --max-columns=512 --hidden --no-ignore -g '!.git'"

M.rg_opts = M.rg_opts_unrestricted .. " " .. rg_ignore_glob

M.fd_opts_unrestricted = "--color=never --type f --hidden --no-ignore --follow -E '.git'"

M.fd_opts = M.fd_opts_unrestricted .. " " .. fd_ignore_glob

M.fzf = function(cmd, opts)
  opts = opts or {}
  return function()
    require("fzf-lua")[cmd](opts)
  end
end

---@type LazySpec
M.spec = {
  {
    "nvim-telescope/telescope.nvim",
    keys = {

      {
        "<leader>,",
        false,
      },
      { "<leader>/", false },
      { "<leader>:", false },
      { "<leader><space>", false },
      { "<leader>fb", false },
      { "<leader>fc", false },
      { "<leader>ff", false },
      { "<leader>fF", false },
      { "<leader>fr", false },
      { "<leader>fR", false },
      { "<leader>gc", false },
      { "<leader>gs", false },
      { "<leader>s", false },
      { "<leader>sa", false },
      { "<leader>sb", false },
      { "<leader>sc", false },
      { "<leader>sC", false },
      { "<leader>sd", false },
      { "<leader>sD", false },
      { "<leader>sg", false },
      { "<leader>sG", false },
      { "<leader>sh", false },
      { "<leader>sH", false },
      { "<leader>sk", false },
      { "<leader>sM", false },
      { "<leader>sm", false },
      { "<leader>so", false },
      { "<leader>sR", false },
      { "<leader>sw", false },
      { "<leader>sW", false },
      { "<leader>sw", false },
      { "<leader>sW", false },
      { "<leader>uC", false },
      {
        "<leader>ss",
        false,
      },
      {
        "<leader>sS",
        false,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = {
        "gd",
        M.fzf("lsp_definitions", { jump_to_single_result = true, winopts = M.win_presets.large.vertical }),
        desc = "Goto Definition",
        has = "definition",
      }
      keys[#keys + 1] = {
        "gd",
        M.fzf("lsp_definitions", { jump_to_single_result = true, winopts = M.win_presets.large.vertical }),
        desc = "Goto Definition",
        has = "definition",
      }
      keys[#keys + 1] = {
        "gr",
        M.fzf("lsp_references", { ignore_current_line = true, winopts = M.win_presets.large.vertical }),
        desc = "References",
      }
      keys[#keys + 1] = {
        "gI",
        M.fzf("lsp_implementations", { jump_to_single_result = true, winopts = M.win_presets.large.vertical }),
        desc = "Goto Implementation",
      }
      keys[#keys + 1] = {
        "gy",
        M.fzf("lsp_typedefs", { jump_to_single_result = true, winopts = M.win_presets.large.vertical }),
        desc = "Goto T[y]pe Definition",
      }
      keys[#keys + 1] = {
        "gD",
        M.fzf("lsp_declarations", { jump_to_single_result = true, winopts = M.win_presets.large.vertical }),
        desc = "Goto Declarations",
      }
      keys[#keys + 1] = {
        "<leader>ca",
        M.fzf("lsp_code_actions", { winopts = M.win_presets.small.no_preview }),
        desc = "Code Action",
        mode = { "n", "v" },
        has = "codeAction",
      }
    end,
  },
  {
    "ibhagwan/fzf-lua",
    lazy = false,
    priority = 200,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader><Space>",
        M.fzf("files", {
          winopts = M.win_presets.medium.vertical,
        }),
        desc = "Files",
      },
      {
        "<leader><S-Space>",
        M.fzf("files", {
          fd_opts = M.fd_opts_unrestricted,
          winopts = M.win_presets.medium.vertical,
        }),
        desc = "Files",
      },
      {
        "<leader>gs",
        M.fzf("git_status", {
          winopts = M.win_presets.large.vertical,
        }),
        desc = "Git Status",
      },
      {
        "<leader>gc",
        M.fzf("git_commits", {
          winopts = M.win_presets.large.vertical,
        }),
        desc = "Git Commits",
      },
      {
        "<leader>fr",
        M.fzf("oldfiles", {
          winopts = M.win_presets.medium.vertical,
        }),
        desc = "Recent Files (Current Session)",
      },
      {
        "<leader>fR",
        M.fzf("oldfiles", {
          winopts = M.win_presets.medium.vertical,
          include_current_session = false,
        }),
        desc = "Recent Files (All Sessions)",
      },
      {
        "<leader>ss",
        M.fzf("lsp_document_symbols", {
          winopts = M.win_presets.large.vertical,
        }),
        desc = "Document Symbols",
      },
      {
        "<leader>sS",
        M.fzf("lsp_live_workspace_symbols", {
          winopts = M.win_presets.large.vertical,
        }),
        desc = "Workspace Symbols",
      },
      {
        "<leader>/",
        M.fzf("lgrep_curbuf", {
          winopts = M.win_presets.large.vertical,
        }),
        desc = "Grep",
      },
      {
        "<leader>sg",
        M.fzf("live_grep_glob", {
          winopts = M.win_presets.large.vertical,
        }),
        desc = "Grep (excluding .git and node_modules)",
      },
      {
        "<leader>sG",
        M.fzf("live_grep_glob", {
          rg_opts = M.rg_opts_unrestricted,
          winopts = M.win_presets.large.vertical,
        }),
        desc = "Grep (excluding .git)",
      },
      { '<leader>s"', M.fzf("registers", { winopts = M.win_presets.large.vertical }), desc = "Registers" },
      { "<leader>sa", M.fzf("autocmds", { winopts = M.win_presets.large.vertical }), desc = "Auto Commands" },
      { "<leader>sc", M.fzf("command_history", { winopts = M.win_presets.large.vertical }), desc = "Command History" },
      { "<leader>sC", M.fzf("commands", { winopts = M.win_presets.large.vertical }), desc = "Commands" },
      {
        "<leader>sd",
        M.fzf("diagnostics_document", { winopts = M.win_presets.large.vertical }),
        desc = "Document Diagnostics",
      },
      {
        "<leader>sD",
        M.fzf("diagnostics_workspace", { winopts = M.win_presets.large.vertical }),
        desc = "Workspace Diagnostics",
      },
      { "<leader>sh", M.fzf("help_tags", { winopts = M.win_presets.large.vertical }), desc = "Help Pages" },
      {
        "<leader>sH",
        M.fzf("highlights", { winopts = M.win_presets.large.vertical }),
        desc = "Search Highlight Groups",
      },
      { "<leader>sm", M.fzf("marks", { winopts = M.win_presets.large.vertical }), desc = "Marks" },
      { "<leader>sk", M.fzf("keymaps", { winops = M.win_presets.large.vertical }), desc = "Key Maps" },
      { "<leader>sM", M.fzf("man_pages", { winopts = M.win_presets.large.vertical }), desc = "Man Pages" },
      -- { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
      { "<leader>sR", M.fzf("resume", { winopts = M.win_presets.large.vertical }), desc = "Resume Picker List" },
      {
        "<leader>sw",
        M.fzf("grep_cword", { winopts = M.win_presets.large.vertical }),
        desc = "Grep Word (excluding .git and node_modules)",
      },
      {
        "<leader>sw",
        M.fzf("grep_visual", {
          winopts = M.win_presets.large.vertical,
        }),
        mode = "v",
        desc = "Grep Visual (excluding .git and node_modules)",
      },
      {
        "<leader>sW",
        M.fzf("grep_cword", {
          rg_opts = M.rg_opts_unrestricted,
          winopts = M.win_presets.large.vertical,
        }),
        desc = "Grep Word (excluding .git)",
      },
      {
        "<leader>sW",
        M.fzf("grep_visual", {
          rg_opts = M.rg_opts_unrestricted,
          winopts = M.win_presets.large.vertical,
        }),
        mode = "v",
        desc = "Grep Visual (excluding .git)",
      },
      {
        "<leader>uC",
        M.fzf("colorschemes", { winopts = M.win_presets.large.vertical }),
        desc = "Colorscheme with preview",
      },
      {
        "<leader>sb",
        M.fzf("buffers", { winopts = M.win_presets.large.vertical }),
        desc = "Buffers with preview",
      },
    },
    opts = function()
      local actions = require("fzf-lua.actions")
      return {
        global_resume = true, -- enable global `resume`?
        global_resume_query = true, -- include typed query in `resume`?
        winopts = {
          height = 0.50, -- window height
          width = 0.75, -- window width
          row = 0.35, -- window row position (0=top, 1=bottom)
          col = 0.50, -- window col position (0=left, 1=right)
          border = "rounded",
          hl = {
            normal = "NeoTreeNormal", -- window normal color (fg+bg)
            border = "FloatBorder", -- border color
            help_border = "FloatBorder", -- <F1> window border
          },
          preview = {
            -- default = "bat",
            border = "noborder", -- border|noborder, applies only to
            wrap = "wrap", -- wrap|nowrap
            hidden = "nohidden", -- hidden|nohidden
            vertical = "down:45%", -- up|down:size
            horizontal = "right:60%", -- right|left:size
            layout = "flex", -- horizontal|vertical|flex
            flip_columns = 120, -- #cols to switch to horizontal on flex
            title = true, -- preview border title (file/buf)?
            scrollbar = false, -- `false` or string:'float|border'
            scrolloff = "-2", -- float scrollbar offset from right
            scrollchars = { "", "" }, -- scrollbar chars ({ <full>, <empty> }
            delay = 100, -- delay(ms) displaying the preview
            winopts = { -- builtin previewer window options
              number = false,
              relativenumber = false,
              cursorline = true,
              cursorlineopt = "both",
              cursorcolumn = false,
              signcolumn = "no",
              list = false,
              foldenable = false,
              foldmethod = "manual",
            },
          },
          -- on_create = function()
          -- vim.cmd("Neotree close")
          -- called once upon creation of the fzf main window
          -- can be used to add custom fzf-lua mappings, e.g:
          -- vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
          -- vim.keymap.set("t", "<C-k>", "<Up>", { silent = true, buffer = true })
          -- end,
        },
        keymap = {
          builtin = {
            ["down"] = "down",
            ["up"] = "up",
            ["<F1>"] = "toggle-help",
            ["<F2>"] = "toggle-fullscreen",

            ["<F3>"] = "toggle-preview-wrap",
            ["<F4>"] = "toggle-preview",
            ["<F5>"] = "toggle-preview-ccw",
            ["<F6>"] = "toggle-preview-cw",

            ["<C-d>"] = "preview-page-down",
            ["<C-u>"] = "preview-page-up",
          },
          fzf = {
            ["down"] = "down",
            ["up"] = "up",
            ["ctrl-c"] = "abort",
            ["ctrl-a"] = "toggle-all",
            ["ctrl-q"] = "select-all+accept",
            ["f3"] = "toggle-preview-wrap",
            ["f4"] = "toggle-preview",
          },
        },
        fzf_opts = {
          -- options are sent as `<left>=<right>`
          -- set to `false` to remove a flag
          -- set to '' for a non-value flag
          -- for raw args use `fzf_args` instead
          ["--ansi"] = "",
          ["--prompt"] = "  ",
          ["--info"] = "inline",
          ["--height"] = "100%",
          ["--layout"] = "reverse",
          ["--keep-right"] = false,
        },
        previewers = {
          cat = {
            cmd = "cat",
            args = "--number",
          },
          bat = {
            cmd = "bat",
            args = "--style=numbers,changes --color always",
            theme = "base16", -- bat preview theme (bat --list-themes)
            config = nil, -- nil uses $BAT_CONFIG_PATH
          },
          head = {
            cmd = "head",
            args = nil,
          },
          git_diff = {
            cmd_deleted = "git diff --color HEAD --",
            cmd_modified = "git diff --color HEAD",
            cmd_untracked = "git diff --color --no-index /dev/null",
            pager = "delta --width $FZF_PREVIEW_COLUMNS",
          },
          man = {
            cmd = "man -c %s | col -bx",
          },
          builtin = {
            syntax = true, -- preview syntax highlight?
            syntax_limit_l = 0, -- syntax limit (lines), 0=nolimit
            syntax_limit_b = 1024 * 1024, -- syntax limit (bytes), 0=nolimit
            extensions = {
              ["png"] = { "viu" },
              ["jpg"] = { "viu" },
            },
          },
        },
        -- provider setup
        files = {
          prompt = "Find File❯ ",
          multiprocess = true, -- run command in a separate process
          git_icons = true, -- show git icons?
          file_icons = true, -- show file icons?
          color_icons = true, -- colorize file|git icons
          find_opts = "-type f -not -path '*/.git/*' -printf '%P\n'",
          rg_opts = M.rg_opts,
          fd_opts = M.fd_opts,
          actions = {
            ["default"] = actions.file_edit_or_qf,
            ["ctrl-s"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
            ["ctrl-q"] = actions.file_sel_to_qf,
            ["ctrl-y"] = function(selected)
              print(selected[1])
            end,
          },
        },
        git = {
          files = {
            prompt = "Git Files❯ ",
            cmd = "git ls-files --exclude-standard",
            multiprocess = false, -- run command in a separate process
            git_icons = true, -- show git icons?
            file_icons = true, -- show file icons?
            color_icons = true, -- colorize file|git icons
          },
          status = {
            prompt = "Modified Files❯ ",
            cmd = "git status -su",
            previewer = "git_diff",
            file_icons = true,
            git_icons = true,
            color_icons = true,
            actions = {
              ["default"] = actions.file_edit_or_qf,
              ["ctrl-s"] = actions.file_split,
              ["ctrl-v"] = actions.file_vsplit,
              ["ctrl-t"] = actions.file_tabedit,
              ["ctrl-q"] = actions.file_sel_to_qf,
              ["right"] = { actions.git_unstage, actions.resume },
              ["left"] = { actions.git_stage, actions.resume },
            },
          },
          commits = {
            prompt = "Commits❯ ",
            cmd = "git log --pretty=oneline --abbrev-commit --color",
            preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
            actions = {
              ["default"] = actions.git_checkout,
            },
          },
          bcommits = {
            prompt = "BCommits❯ ",
            cmd = "git log --pretty=oneline --abbrev-commit --color",
            preview = "git show --pretty='%Cred%H%n%Cblue%an%n%Cgreen%s' --color {1}",
            actions = {
              ["default"] = actions.git_buf_edit,
              ["ctrl-s"] = actions.git_buf_split,
              ["ctrl-v"] = actions.git_buf_vsplit,
              ["ctrl-t"] = actions.git_buf_tabedit,
            },
          },
          branches = {
            prompt = "Branches❯ ",
            cmd = "git branch --all --color",
            preview = "git log --graph --pretty=oneline --abbrev-commit --color {1}",
            actions = {
              ["default"] = actions.git_switch,
            },
          },
          icons = {
            ["M"] = { icon = "M", color = "yellow" },
            ["D"] = { icon = "D", color = "red" },
            ["A"] = { icon = "A", color = "green" },
            ["R"] = { icon = "R", color = "yellow" },
            ["C"] = { icon = "C", color = "yellow" },
            ["?"] = { icon = "?", color = "magenta" },
          },
        },
        grep = {
          prompt = "Grep Text❯ ",
          input_prompt = "Grep For❯ ",
          multiprocess = true, -- run command in a separate process
          git_icons = true, -- show git icons?
          file_icons = true, -- show file icons?
          color_icons = true, -- colorize file|git icons
          rg_opts = M.rg_opts,
          grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp",
          -- 'live_grep_glob' options:
          glob_flag = "--iglob", -- for case sensitive globs use '--glob'
          glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
        },
        args = {
          prompt = "Args❯ ",
          files_only = true,
          -- added on top of regular file actions
          actions = { ["ctrl-x"] = actions.arg_del },
        },
        oldfiles = {
          prompt = "History❯ ",
          cwd_only = true,
          stat_file = true, -- verify files exist on disk
          include_current_session = true, -- include bufs from current session
        },
        buffers = {
          prompt = "Buffers❯ ",
          file_icons = true, -- show file icons?
          color_icons = true, -- colorize file|git icons
          sort_lastused = true, -- sort buffers() by last used
          cwd_only = true, -- buffers for the cwd only
          cwd = nil, -- buffers list for a given dir
          actions = {
            ["ctrl-x"] = { actions.buf_del, actions.resume },
          },
        },
        lines = {
          previewer = "builtin", -- set to 'false' to disable
          prompt = "Lines❯ ",
          show_unlisted = false, -- exclude 'help' buffers
          no_term_buffers = true, -- exclude 'term' buffers
          fzf_opts = {
            -- do not include bufnr in fuzzy matching
            -- tiebreak by line no.
            ["--delimiter"] = vim.fn.shellescape("]"),
            ["--nth"] = "2..",
            ["--tiebreak"] = "index",
          },
          actions = {
            ["default"] = actions.buf_edit,
            ["ctrl-s"] = actions.buf_split,
            ["ctrl-v"] = actions.buf_vsplit,
            ["ctrl-t"] = actions.buf_tabedit,
          },
        },
        blines = {
          previewer = "builtin", -- set to 'false' to disable
          prompt = "BLines❯ ",
          show_unlisted = true, -- include 'help' buffers
          no_term_buffers = false, -- include 'term' buffers
          fzf_opts = {
            -- hide filename, tiebreak by line no.
            ["--delimiter"] = vim.fn.shellescape("[:]"),
            ["--with-nth"] = "2..",
            ["--tiebreak"] = "index",
          },
          actions = {
            ["default"] = actions.buf_edit,
            ["ctrl-s"] = actions.buf_split,
            ["ctrl-v"] = actions.buf_vsplit,
            ["ctrl-t"] = actions.buf_tabedit,
          },
        },
        colorschemes = {
          prompt = "Colorschemes❯ ",
          live_preview = true, -- apply the colorscheme on preview?
          actions = { ["default"] = actions.colorscheme },
          winopts = { height = 0.55, width = 0.30 },
        },
        quickfix = {
          file_icons = true,
          git_icons = true,
        },
        lsp = {
          prompt_postfix = "❯ ", -- will be appended to the LSP label
          cwd_only = true, -- LSP/diagnostics for cwd only?
          async_or_timeout = 5000, -- timeout(ms) or 'true' for async calls
          file_icons = true,
          git_icons = true,
          symbols = {
            async_or_timeout = true, -- symbols are async by default
            symbol_style = 1, -- style for document/workspace symbols
            symbol_hl_prefix = "CmpItemKind",
            symbol_fmt = function(s)
              return "[" .. s .. "]"
            end,
          },
          code_actions = {
            prompt = "Code Actions> ",
            ui_select = true, -- use 'vim.ui.select'?
            async_or_timeout = 5000,
            winopts = {
              row = 0.40,
              height = 0.35,
              width = 0.60,
            },
          },
        },
        file_icon_padding = "",
        file_icon_colors = {
          ["lua"] = "blue",
        },
      }
    end,
    config = function(_, opts)
      require("fzf-lua").setup(opts)
    end,
  },
}

return M.spec
