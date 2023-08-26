-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.winbar = "%=%m %f"
vim.cmd("autocmd User TelescopePreviewerLoaded setlocal number")
vim.opt.conceallevel = 0 -- Do not hide * markup for bold and italic
vim.opt.relativenumber = false -- Show relative line numbers
vim.opt.wrap = true -- Enable line wrap
vim.opt.breakindent = true -- Keep indentation on wrapped lines
