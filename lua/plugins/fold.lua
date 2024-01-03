return {
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      keys[#keys + 1] = { "K", false }
    end,
  },
  { -- better statuscolumn
    "luukvbaal/statuscol.nvim",
    event = { "LazyFile" },
    opts = function()
      local builtin = require("statuscol.builtin")
      return {
        ft_ignore = {
          "neo-tree",
          "neo-tree-popup",
          "dashboard",
          "lazy",
          "mason",
          "symbols-outline",
          "chatpgpt",
          "diagmsg",
          "fzf",
          "neotest-output",
        },
        segments = {
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
          {
            sign = { name = { "Diagnostic*" }, text = { ".*" }, maxwidth = 1, colwidth = 1, auto = true },
            click = "v:lua.ScSa",
          },
          { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
        },
      }
    end,
    init = function() end,
    config = function(_, opts)
      require("statuscol").setup(opts)
    end,
  },
  { -- better fold
    "kevinhwang91/nvim-ufo",
    event = { "LazyFile" },
    dependencies = { "kevinhwang91/promise-async" },
    init = function()
      vim.o.foldcolumn = "1"
      vim.o.foldlevel = 99
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    end,
    opts = function()
      return {
        provider_selector = function()
          return { "treesitter", "indent" }
        end,
        open_fold_hl_timeout = 400,
        close_fold_kinds = { "imports", "comment" },
        preview = {
          win_config = { border = { "", "─", "", "", "", "─", "", "" }, winblend = 0 },
          mappings = {
            scrollU = "<C-b>",
            scrollD = "<C-f>",
            jumpTop = "[",
            jumpBot = "]",
          },
        },
      }
    end,
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
      {
        "zr",
        function()
          require("ufo").openFoldsExceptKinds()
        end,
        desc = "Open folds except kinds",
      },
      {
        "zm",
        function()
          require("ufo").closeFoldsWith()
        end,
        desc = "Close folds with",
      },
      {
        "K",
        function()
          if not require("ufo").peekFoldedLinesUnderCursor() then
            vim.lsp.buf.hover()
          end
        end,
        desc = "Peek folded lines under cursor",
      },
    },
  },
}
