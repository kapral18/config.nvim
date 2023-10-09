-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  callback = function()
    vim.wo.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown" },
  callback = function()
    vim.wo.spell = true
  end,
})

-- disable copilot for large files
-- disable syntax highlighting for large files
vim.api.nvim_create_autocmd({ "BufReadPre" }, {
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
