local function get_extends_path(node_modules_path, str)
  local resulting_path = node_modules_path
  if vim.startswith(str, "plugin:") then
    local config = string.gsub(str, "plugin:", "")

    local separator = string.find(config, "/")

    local config_name = config
    local config_version = nil
    if separator ~= nil then
      local config_parts = vim.split(config, "/")
      config_name = config_parts[1]
      config_version = config_parts[2]
    end

    if vim.startswith(config_name, "@") then
      local starting_path = vim.fs.joinpath(resulting_path, config_name, "eslint-plugin")
      if config_version ~= nil then
        local found = vim.fs.find(config_version .. ".js", { path = starting_path })
        if vim.tbl_isempty(found) then
          vim.notify("No version found, serving package.json instead", vim.log.levels.INFO)
          return vim.fs.joinpath(starting_path, "package.json")
        end

        return found[1]
      else
        return vim.fs.joinpath(starting_path, "package.json")
      end
    end

    if config_version ~= nil then
      local found = vim.fs.find(
        config_version .. ".js",
        { path = vim.fs.joinpath(resulting_path, "eslint-plugin-" .. config_name) }
      )
      if vim.tbl_isempty(found) then
        vim.notify("No version found serving package.json", vim.log.levels.INFO)
        return vim.fs.joinpath(resulting_path, "eslint-plugin-" .. config_name, "package.json")
      end
      return found[1]
    else
      return vim.fs.joinpath(resulting_path, "eslint-plugin-" .. config_name, "package.json")
    end
  end

  if vim.startswith(str, "eslint:") then
    return vim.fs.joinpath(resulting_path, "eslint", "package.json")
  end
  local separator = string.find(str, ":")
  local config_name = str

  if separator ~= nil then
    config_name, _ = vim.split(str, ":")
  end

  return vim.fs.joinpath(resulting_path, "eslint-config-" .. config_name, "package.json")
end

local function get_plugins_path(node_modules_path, str)
  local resulting_path = node_modules_path
  if vim.startswith(str, "@") then
    local starting_path = vim.fs.joinpath(resulting_path, str, "eslint-plugin")
    return vim.fs.joinpath(starting_path, "package.json")
  end

  return vim.fs.joinpath(resulting_path, "eslint-plugin-" .. str, "package.json")
end

local function get_rules_path(node_modules_path, str)
  local config_parts = vim.split(str, "/")
  local rule_scope = config_parts[1]
  local rule_name = config_parts[2]

  local found_rules = vim.fs.find((rule_name or rule_scope) .. ".js", { path = node_modules_path, limit = math.huge })

  if vim.tbl_isempty(found_rules) then
    if vim.startswith(rule_scope, "@") then
      local found_dir =
        vim.fs.find("package.json", { path = vim.fs.joinpath(node_modules_path, rule_scope), limit = math.huge })
      if #found_dir > 0 then
        return found_dir[1]
      end
    end

    if rule_scope ~= nil and rule_name ~= nil then
      local found_dir = vim.fs.find("package.json", {
        path = vim.fs.joinpath(node_modules_path, "eslint-plugin-" .. rule_scope),
        limit = math.huge,
      })
      if #found_dir > 0 then
        return found_dir[1]
      end
    end

    vim.notify("No rule found", vim.log.levels.WARN)
    return
  end

  if #found_rules > 1 then
    vim.ui.select(found_rules, {
      prompt = "Select rule",
      format_item = function(item)
        -- strip off absolute path, only keep relative path from root
        return vim.fn.fnamemodify(item, ":.")
      end,
    }, function(selected)
      if not selected then
        vim.notify("No rule selected", vim.log.levels.WARN)
        return
      end

      vim.cmd("edit " .. selected)
    end)

    return
  end

  return found_rules[1]
end

local function get_eslint_path()
  local buf_dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  local root_dir = vim.fs.find(".git", { upward = true, type = "directory", path = buf_dir })
  if vim.tbl_isempty(root_dir) then
    vim.notify("No git directory found", vim.log.levels.WARN)
    return
  end

  local git_dir = root_dir[1]

  local node_modules =
    vim.fs.find("node_modules", { upward = true, type = "directory", stop = git_dir, path = buf_dir })

  if vim.tbl_isempty(node_modules) then
    vim.notify("No node_modules directory found", vim.log.levels.WARN)
    return
  end

  local node_modules_path = node_modules[1]

  local cursor_row, cursor_col = unpack(vim.api.nvim_win_get_cursor(0))
  -- treesitter is 0 indexed
  cursor_row = cursor_row - 1

  local bufnr = vim.api.nvim_get_current_buf()
  local parser = vim.treesitter.get_parser(bufnr, "typescript")
  local trees = parser:parse()
  local tree = trees[1]
  local root = tree:root()

  local cursor_node = root:descendant_for_range(cursor_row, cursor_col, cursor_row, cursor_col)
  if cursor_node == nil then
    vim.notify("Cursor was not within a node", vim.log.levels.WARN)
    return
  end

  local cursor_node_text = vim.treesitter.get_node_text(cursor_node, bufnr)

  local parent = cursor_node:parent()
  while parent ~= nil do
    local type = parent:type()
    if type == "pair" and parent:child_count() > 0 then
      local child = parent:child(0)
      if not child then
        vim.notify("No key found", vim.log.levels.WARN)
        return
      end

      if child:type() == "property_identifier" then
        local name = vim.treesitter.get_node_text(child, bufnr)
        if name == "extends" then
          return get_extends_path(node_modules_path, cursor_node_text)
        end
        if name == "plugins" then
          return get_plugins_path(node_modules_path, cursor_node_text)
        end
        if name == "rules" then
          return get_rules_path(node_modules_path, cursor_node_text)
        end
      end
    end
    parent = parent:parent()
  end
end

local function open_eslint_path()
  local eslint_path = get_eslint_path()

  if eslint_path then
    vim.cmd("edit " .. eslint_path)
  end
end

vim.keymap.set("n", "<leader>sf", open_eslint_path, { desc = "Open eslint path" })
