local Util = require("lazyvim.util")
-- this is a local variable that controls size of the terminal
local terminal_size = 20

return {
  {
    "akinsho/toggleterm.nvim",
    config = function(opts)
      require("toggleterm").setup(vim.tbl_deep_extend("force", opts, {
        size = function(term)
          if term.direction == "horizontal" then
            return terminal_size
          elseif term.direction == "vertical" then
            return vim.o.columns * (terminal_size / 100)
          end
        end,
      }))

      -- remove default lazyvim mapping for toggling terminal from inside terminal
      vim.keymap.del({ "t" }, "<C-/>")
      -- remove default lazyvim mapping for toggling terminal from normal mode
      vim.keymap.del({ "n" }, "<c-/>")
    end,
    keys = {
      {
        "<m-)>0",
        '<Cmd>execute v:count . "ToggleTerm"<CR>',
        desc = "Toggle Terminal",
        silent = true,
      },
      {
        "<m-)>0",
        '<Esc><Cmd>execute v:count . "ToggleTerm"<CR>',
        mode = { "i", "t" },
        desc = "Torggle Terminal",
        silent = true,
      },
      {
        "<m-)>h",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, terminal_size, Util.get_root(), "horizontal")
        end,
        desc = "ToggleTerm (horizontal)",
      },
      {
        "<m-)>v",
        function()
          local count = vim.v.count1
          require("toggleterm").toggle(count, vim.o.columns * (terminal_size / 100), Util.get_root(), "vertical")
        end,
        desc = "ToggleTerm (vertical)",
      },
    },
  },
}
