local Util = require("lazyvim.util")

-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set(
  "n",
  "<leader>sx",
  require("telescope.builtin").resume,
  { noremap = true, silent = true, desc = "Resume" }
)

-- map shift j and shift k to beginning and end of line
vim.keymap.set({ "n", "v" }, "<S-h>", "g^", { noremap = true, silent = true, desc = "Go to beginning of line" })
vim.keymap.set({ "n", "v" }, "<S-l>", "g$", { noremap = true, silent = true, desc = "Go to end of line" })
-- map alt h and alt l to next and previous buffers

if Util.has("bufferline.nvim") then
  vim.keymap.set(
    "n",
    "<A-h>",
    Util.has("bufferline.nvim") and "<cmd>BufferLineCyclePrev<CR>" or ":bprevious<CR>",
    { noremap = true, silent = true, desc = "Previous buffer" }
  )
  vim.keymap.set(
    "n",
    "<A-l>",
    Util.has("bufferline.nvim") and "<cmd>BufferLineCycleNext<CR>" or ":bnext<CR>",
    { noremap = true, silent = true, desc = "Next buffer" }
  )
end

-- advanceg-git-search
vim.keymap.set({ "n", "v" }, "<leader>fgg", ":AdvancedGitSearch<CR>", { desc = "AdvancedGitSearch" })
vim.keymap.set(
  { "n", "v" },
  "<leader>fgr",
  ":AdvancedGitSearch search_log_content<CR>",
  { desc = "AGS Repo History Search" }
)
vim.keymap.set(
  { "n", "v" },
  "<leader>fgf",
  ":AdvancedGitSearch search_log_content_file<CR>",
  { desc = "AGS File History Search" }
)
vim.keymap.set({ "n", "v" }, "<leader>fgdf", ":AdvancedGitSearch diff_commit_file<CR>", { desc = "AGS File vs commit" })
vim.keymap.set({ "n", "v" }, "<leader>fgdl", ":AdvancedGitSearch diff_commit_line<CR>", { desc = "AGS Line vs commit" })
vim.keymap.set(
  { "n", "v" },
  "<leader>fgdb",
  ":AdvancedGitSearch diff_branch_file<CR>",
  { desc = "AGS Branch vs commit" }
)
vim.keymap.set({ "n", "v" }, "<leader>fgre", ":AdvancedGitSearch checkout_reflog<CR>", { desc = "AGS Checkout reflog" })
vim.keymap.set({ "n", "v" }, "<leader>fgx", ":DiffviewClose<CR>", { desc = "DiffviewClose" })

-- telescope
vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { desc = "branches" })
vim.keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>", { desc = "commits" })
vim.keymap.set("n", "<leader>gC", ":Telescope git_bcommits<CR>", { desc = "buffer commits" })
