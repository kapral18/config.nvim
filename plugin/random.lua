local function open_scratch_buffer()
  -- Create a new buffer
  local buf = vim.api.nvim_create_buf(false, true)

  vim.api.nvim_set_option_value("buftype", "nofile", { buf = buf })
  vim.api.nvim_set_option_value("bufhidden", "hide", { buf = buf })
  vim.api.nvim_set_option_value("swapfile", false, { buf = buf })
  vim.api.nvim_set_option_value("filetype", "scratch", { buf = buf })

  -- Create a new window
  vim.api.nvim_open_win(buf, true, {
    relative = "win",
    width = vim.api.nvim_get_option_value("columns", {}) - 10,
    height = vim.api.nvim_get_option_value("lines", {}) - 10,
    row = 2,
    col = 2,
    border = "single",
    style = "minimal",
  })
end

vim.api.nvim_create_user_command("OpenScratchBuffer", open_scratch_buffer, {})

local function kill_all_buffers()
  local bufs = vim.api.nvim_list_bufs()
  local current_buf = vim.api.nvim_get_current_buf()
  for _, buf in ipairs(bufs) do
    if buf ~= current_buf then
      vim.api.nvim_buf_delete(buf, {})
    end
  end
end

vim.api.nvim_create_user_command("KillAllBuffers", kill_all_buffers, {})
