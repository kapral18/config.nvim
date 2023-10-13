local function getTelescopeOpts(state, path)
  return {
    cwd = path,
    search_dirs = { path },
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local action_state = require("telescope.actions.state")
        local selection = action_state.get_selected_entry()
        local filename = selection.filename
        if filename == nil then
          filename = selection[1]
        end
        -- any way to open the file without triggering auto-close event of neo-tree?
        require("neo-tree.sources.filesystem").navigate(state, state.path, filename)
      end)
      return true
    end,
  }
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      filtered_items = {
        visible = true, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false, -- only works on Windows for hidden files/directories
        hide_by_name = {
          --"node_modules",
        },
        hide_by_pattern = {
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --".gitignored",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          --".DS_Store",
          --"thumbs.db",
        },
        never_show_by_pattern = { -- uses glob style patterns
          --".null-ls_*",
        },
      },
    },
    window = {
      mappings = {
        ["tf"] = "telescope_find",
        ["tg"] = "telescope_grep",
        ["D"] = "diff_files",
      },
    },
    commands = {
      telescope_find = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require("telescope.builtin").find_files(getTelescopeOpts(state, path))
      end,
      telescope_grep = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        require("telescope.builtin").live_grep(getTelescopeOpts(state, path))
      end,
      diff_files = function(state)
        local node = state.tree:get_node()
        local log = require("neo-tree.log")
        state.clipboard = state.clipboard or {}
        if diff_Node and diff_Node ~= tostring(node.id) then
          local current_Diff = node.id
          require("neo-tree.utils").open_file(state, diff_Node, open)
          vim.cmd("vert diffs " .. current_Diff)
          log.info("Diffing " .. diff_Name .. " against " .. node.name)
          diff_Node = nil
          current_Diff = nil
          state.clipboard = {}
          require("neo-tree.ui.renderer").redraw(state)
        else
          local existing = state.clipboard[node.id]
          if existing and existing.action == "diff" then
            state.clipboard[node.id] = nil
            diff_Node = nil
            require("neo-tree.ui.renderer").redraw(state)
          else
            state.clipboard[node.id] = { action = "diff", node = node }
            diff_Name = state.clipboard[node.id].node.name
            diff_Node = tostring(state.clipboard[node.id].node.id)
            log.info("Diff source file " .. diff_Name)
            require("neo-tree.ui.renderer").redraw(state)
          end
        end
      end,
    },
  },
}
