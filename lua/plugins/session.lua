return {

  { "folke/persistence.nvim", enabled = false },
  {
    "rmagatti/auto-session",
    opts = {
      log_level = "error",
      auto_session_suppress_dirs = { "/", "~/", "~/LP", "~/Downloads", "~/code" },
      auto_save_enabled = true,
    },
  },
}
