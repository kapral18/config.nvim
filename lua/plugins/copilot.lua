return {
  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    opts = {
      filetypes = {
        ["*"] = true,
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<A-CR>",
          accept_line = "<A-L>",
          accept_word = "<A-W>",
          next = "<A-]>",
          prev = "<A-[>",
          dismiss = "<A-c>",
        },
      },
    },
  },
}
