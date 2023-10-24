-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.winbar = "%=%m %f"
vim.opt.conceallevel = 0 -- Do not hide * markup for bold and italic
vim.opt.relativenumber = false -- Show relative line numbers
vim.opt.wrap = true -- Enable line wrap
vim.opt.breakindent = true -- Keep indentation on wrapped lines
vim.opt.pumblend = 0 -- disable transparency in popup menu

-- https://vi.stackexchange.com/a/5318/12823
vim.g.matchparen_timeout = 2
vim.g.matchparen_insert_timeout = 2

-- custom dockerfile filetype association
vim.filetype.add({ pattern = { ["Dockerfile.*"] = "dockerfile" } })
