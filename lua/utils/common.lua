local M = {}

-- check if file is git tracked
-- for example to be used with git mv
--@param filename string
M.is_git_tracked = function(filename)
  local handle, err = io.popen("git ls-files " .. filename)
  if handle == nil then
    print("Failed to run git ls-files command: " .. err)
    return false
  end

  local result = handle:read("*a")
  handle:close()

  if result == "" then
    return false
  else
    return true
  end
end

-- show confirm input
--@param message string
--@param callback function
M.confirm = function(message, callback)
  local opts = {
    prompt = message .. " y/n: ",
  }
  vim.ui.input(opts, function(value)
    callback(value == "y" or value == "Y")
  end)
end

return M
