return {
  -- Disable certain features if file is big
  {
    "LunarVim/bigfile.nvim",
    opts = {
      filesize = 0.5,
    },
  },
}
