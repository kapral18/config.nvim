return {
  "ThePrimeagen/harpoon",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<A-m>",
      function()
        require("harpoon.ui").toggle_quick_menu()
      end,
      desc = "Harpoon Toggle",
      noremap = true,
    },
    {
      "<A-a>",
      function()
        require("harpoon.mark").add_file()
      end,
      desc = "Harpoon Mark",
      noremap = true,
    },
    {
      "<F1>",
      function()
        require("harpoon.ui").nav_file(1)
      end,
      desc = "Harpoon 1",
    },
    {
      "<F2>",
      function()
        require("harpoon.ui").nav_file(2)
      end,
      desc = "Harpoon 2",
    },
    {
      "<F3>",
      function()
        require("harpoon.ui").nav_file(3)
      end,
      desc = "Harpoon 3",
    },
    {
      "<F4>",
      function()
        require("harpoon.ui").nav_file(4)
      end,
      desc = "Harpoon 4",
    },
    {
      "<F5>",
      function()
        require("harpoon.ui").nav_file(5)
      end,
      desc = "Harpoon 5",
    },
  },
  opts = {
    global_settings = {
      save_on_toggle = true,
      save_on_change = true,
    },
  },
}
