return {
  -- Disable certain features if file is big
  {
    "LunarVim/bigfile.nvim",
    events = "LazyFile",
    opts = {
      filesize = 0.5,
    },
  },
}
