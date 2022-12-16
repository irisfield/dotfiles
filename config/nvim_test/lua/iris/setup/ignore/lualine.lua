local exist, lualine = pcall(require, "lualine")

if not exist then
  return
end

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

-- local diagnostics = {
--   "diagnostics",
--   sources = { "nvim_diagnostic" },
--   sections = { "error", "warn" },
--   symbols = { error = " ", warn = " " },
--   colored = false,
--   update_in_insert = false,
--   always_visible = true,
-- }

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
  icon = nil,
}

local branch = {
  "branch",
  icons_enabled = true,
  icon = "",
}

-- shiftwidth:character_count
local function location()
  return vim.api.nvim_buf_get_option(0, "shiftwidth") .. ":%-2v"
end

-- cute progress function
local function progress()
  local current_line = vim.fn.line(".")
  local total_lines = vim.fn.line("$")
  local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
  local line_ratio = current_line / total_lines
  local index = math.ceil(line_ratio * #chars)
  return chars[index]
end

-- stylua: ignore
local colors = {
  blue   = "#80a0ff",
  cyan   = "#79dac8",
  black  = "#080808",
  white  = "#c6c6c6",
  red    = "#ff5189",
  violet = "#d183e8",
  grey   = "#303030",
}

-- theme
local bubbles = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.black, bg = colors.black },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.black },
  },
}

lualine.setup({
  options = {
    theme = bubbles,
    icons_enabled = true,
    component_separators = "|",
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {
      { "mode", separator = { left = "" }, right_padding = 1 },
    },
    lualine_b = { branch, "filename" },
    lualine_c = { "fileformat" },
    lualine_x = { diff },
    lualine_y = { "encoding", filetype, progress },
    lualine_z = {
      { location, separator = { right = "" }, left_padding = 1 },
    },
  },
  inactive_sections = {
    lualine_a = { "filename" },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "location" },
  },
  tabline = {},
  extensions = {},
})
