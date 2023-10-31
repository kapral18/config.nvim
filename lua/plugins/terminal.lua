-- this is a local variable that controls size of the terminal
local terminal_size = 20

return {
  {
    "akinsho/toggleterm.nvim",
    lazy = false,
    opts = {
      size = function(term)
        if term.direction == "horizontal" then
          return terminal_size
        elseif term.direction == "vertical" then
          return vim.o.columns * (terminal_size / 100)
        end
      end,
      start_in_insert = false,
    },
    keys = {
      {
        "<a-t>t",
        '<Cmd>execute v:count . "ToggleTerm"<CR>',
        desc = "Toggle Terminal",
        silent = true,
      },
      {
        "<a-t>t",
        '<Esc><Cmd>execute v:count . "ToggleTerm"<CR>',
        desc = "Toggle Terminal",
        mode = { "t", "i" },
        silent = true,
      },
      {
        "<a-t>h",
        '<Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>',
        desc = "ToggleTerm (horizontal)",
      },
      {
        "<a-t>h",
        '<Esc><Cmd>execute v:count . "ToggleTerm direction=horizontal"<CR>',
        desc = "Toggle Terminal (horizontal)",
        mode = { "t", "i" },
        silent = true,
      },
      {
        "<a-t>v",
        '<Cmd>execute v:count . "ToggleTerm direction=vertical"<CR>',
        desc = "ToggleTerm (vertical)",
        silent = true,
      },
      {
        "<a-t>v",
        '<Esc><Cmd>execute v:count . "ToggleTerm direction=vertical"<CR>',
        desc = "Toggle Terminal (vertical)",
        mode = { "t", "i" },
        silent = true,
      },
    },
  },
}
