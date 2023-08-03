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
