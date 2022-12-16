local options = {
  autoindent = true, -- copy indent from current line when starting a new line
  autowrite = true, -- write the contents of a file if it has been modified on certain commands
  autowriteall = true, -- write the contents of a file if it has been modified on certain commands
  backup = false, -- make a backup before overwriting a file
  clipboard = "unnamedplus", -- always use the system clipboard (xsel) for all operations
  cmdheight = 1, -- number lines to use for the command-line
  completeopt = { -- comma separated list of options for insert mode completion (:h "completeopt")
    "menuone",
    "noselect",
  },
  conceallevel = 0, -- makes `` visible in markdown files
  cursorline = true, -- highlight the line of the cursor (useful to spot the cursor)
  expandtab = true, -- use a corresponding number of spaces in place of <Tab>
  fileencoding = "utf-8", -- file-content encoding for the current buffer
  hlsearch = false, -- when there is a previous search pattern, highlight all its matches
  ignorecase = true, -- ignore case in search patterns (can be overruled by "\c" or "\C" and smartcase option)
  inccommand = "split", -- show the results of commands incrementally in the buffer (:h "inccommand")
  incsearch = true, -- show the results of the patterns matched while typing
  hidden = false, -- unload buffer when it is abandoned (closed)
  list = true, -- enable list mode to display invisible characters
  listchars = { -- string to use in list mode
    tab = "‣ˑ",
    trail = "·",
  },
  mouse = "a", -- enable mouse support for "a"ll modes
  number = true, -- print the line number in front of each line (can be combined with relativenumber)
  relativenumber = true, -- show the line number relative to the line with the cursor in front of each line
  numberwidth = 4, -- number of columns to use for the line number (to be used with number/relative number)
  pumheight = 10, -- maximum number of items to show in popup-menu
  pumblend = 30, -- enables pseudo-transparency for popup-menu
  scrolloff = 8, -- minimal number of lines to keep above and below the cursor
  shell = "zsh", -- name of the shell use for "!" and ":!" commands
  shiftwidth = 2, -- number of spaces to use for each step of (auto)indent, >>, and << operations
  showmatch = true, -- when a bracket, brace, or parenthesis is inserted, briefly jump to the matching one
  showmode = false, -- show a message on the last line depending on the mode (INSERT, NORMAL, etc)
  showtabline = 1, -- show tab page label if there are at least two tabs pages open (:h "showtabline")
  sidescroll = 8, -- minimal number of columns to scroll horizontally
  sidescrolloff = 8, -- minimal number of screen columns to keep to the left and right of the cursor
  signcolumn = "yes", -- always display the sign column that way it is not get annoying with LSP configured
  smartcase = true, -- override "ignorecase" option if search pattern contains uppercase characters
  smartindent = true, -- syntax aware autoindent when starting a new line (use alongside autoindent option)
  splitbelow = true, -- splitting a window will put the new window below the current one (:split)
  splitright = true, -- splitting a window will put the new window right of current one (:vsplit)
  swapfile = false, -- use a swapfile for the buffer
  tabstop = 2, -- number of spaces <Tab> inserts (should also change shiftwidth)
  termguicolors = true, -- enable 24-bit true color in the TUI
  textwidth = 0, -- number of characters to break line (wrapmargin must be set to 0)
  timeoutlen = 1500, -- time in milliseconds to wait for a mapped sequence to complete (default 1000)
  undofile = true, -- automatically save an undo history to an undo file when writing a buffer to a file
  updatetime = 300, -- time in milliseconds of no cursor movement to trigger CursorHold (default 4000)
  wildoptions = "pum", -- display the completion matches using the popup-menu
  wrap = false, -- lines longer than the width of the window will wrap and continue displaying on the next line
  wrapmargin = 0, -- number of characters from the right window to break line (textwidth must be set to 0)
  writebackup = false, -- make a backup before overwriting a file
}

-- apply options
for key, value in pairs(options) do
  vim.opt[key] = value
end

-- (https://neovim.io/doc/user/options.html#'shortmess')
vim.opt.shortmess = vim.opt.shortmess
    -- default "filnxtToOF"
    - "i" -- use '[noel]' instead of '[Incomplete last line]'
    + "I" -- do not show the intro message when starting neovim
    + "c" -- do not pass ins-completion-menu status messages

vim.opt.iskeyword = vim.opt.iskeyword
    + "-" -- treat dash-separated words as one word (text object)
    - "_" -- treat underscore_seperated words as seperate words (text object)

-- this gets overwritten by ftplugins (:verb set fo)
-- (https://neovim.io/doc/user/change.html#fo-table)
vim.opt.formatoptions = vim.opt.formatoptions
    -- default "tcqj"
    + "t" -- auto-wrap text using textwidth
    - "c" -- auto-wrap comments using textwidth, inserting the current comment leader automatically (or <C-u>)
    - "q" -- allow formatting comments with <gq>
    + "M" -- when joining lines, don't insert a space before or after a multibyte character
    + "1" -- do not break a line after a one-letter word, break it before instead (if possible)
    + "j" -- where it makes sense, remove a comment leader when joining lines
    + "l" -- when entering insert mode, break lines longer than 'textwidth'
    - "]" -- respect textwidth rigorously (with this flag set, no line can be longer than textwidth)

local builtins = {
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "tutor_mode_plugin",
  "fzf",
  "matchit",
  "shada_plugin",
}

-- disable builtins
for _, plugin in pairs(builtins) do
  vim.g["loaded_" .. plugin] = 1
end
