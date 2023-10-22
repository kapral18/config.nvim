local augrp = vim.api.nvim_create_augroup
local aucmd = vim.api.nvim_create_autocmd

augrp("k18", {})

-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
aucmd({ "FileType" }, {
  group = "k18",
  pattern = { "markdown" },
  callback = function()
    vim.wo.spell = true
  end,
})

aucmd({ "FileType" }, {
  group = "k18",
  pattern = { "markdown" },
  callback = function()
    vim.wo.spell = true
  end,
})

-- disable copilot for large files
-- disable syntax highlighting for large files
aucmd({ "BufReadPre" }, {
  group = "k18",
  pattern = { "*" },
  callback = function()
    local file = vim.fn.expand("<afile>")
    local file_size = vim.fn.getfsize(file)
    if file_size > 100000 or file_size == -2 then
      vim.b.copilot_enabled = false
      vim.wo.spell = false
      vim.opt_local.synmaxcol = 250
      -- disable some formatoptions
      vim.opt_local.formatoptions:remove({ "a", "t" })
    end
  end,
})

--persist folds
aucmd({ "BufLeave", "BufWinLeave" }, {
  group = "k18",
  pattern = "*",
  callback = function()
    vim.cmd([[silent! mkview]])
  end,
  desc = "Remember folds on buffer exit",
})

aucmd("BufReadPost", {
  group = "k18",
  pattern = "*",
  callback = function()
    vim.cmd([[silent! loadview]])
  end,
  desc = "Restore folds on buffer enter",
})
