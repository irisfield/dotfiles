local tfound, nvim_tree = pcall(require, "nvim-tree")

if not tfound then
  return
end

local tree_cb = require("nvim-tree.config").nvim_tree_callback

nvim_tree.setup({
  sync_root_with_cwd = true,
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  view = {
    adaptive_size = true,
    centralize_selection = true,
    side = "right",
    number = true,
    relativenumber = true,
    mappings = {
      list = {
        { key = { "l", "<CR>", "o" }, cb = tree_cb("edit") },
        { key = "h", cb = tree_cb("close_node") },
        { key = "v", cb = tree_cb("vsplit") },
        { key = "D", action = "" } -- disable the trash file mapping
      },
    },
  },
  renderer = {
    icons = {
      glyphs = {
        default = "",
        git = {
          unstaged = "",
          staged = "S",
          renamed = "➜",
          untracked = "U",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
})
