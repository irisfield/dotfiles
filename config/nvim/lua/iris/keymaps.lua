-- (https://neovim.io/doc/user/intro.html#tab)
local keymaps = {
  insert_mode = {
    ["<C-z>"] = "<ESC>:w<CR>", -- write buffer to file
  },
  normal_mode = { ["<C-z>"] = ":w<CR>", -- write buffer to file
    ["<A-d>"] = ":bdelete<CR>", -- close buffer
    ["<leader>e"] = ":NvimTreeToggle<CR>", -- open file explorer
    -- keep the cursor centered
    ["n"] = "nzz",
    ["N"] = "Nzz",
    -- switch between tabs
    ["<A-h>"] = ":tabprevious<CR>",
    ["<A-l>"] = ":tabnext<CR>",
    -- switch between buffers
    ["<A-j>"] = ":bprevious<CR>",
    ["<A-k>"] = ":bnext<CR>",
    -- switch between split windows
    ["<C-h>"] = "<C-w>h",
    ["<C-j>"] = "<C-w>j",
    ["<C-k>"] = "<C-w>k",
    ["<C-l>"] = "<C-w>l",
    -- resize split window
    ["<C-Up>"] = ":resize +2<CR>",
    ["<C-Down>"] = ":resize -2<CR>",
    ["<C-Left>"] = ":vertical resize +2<CR>",
    ["<C-Right>"] = ":vertical resize -2<CR>",
    -- telescope
    -- ["<leader>t"] = ":Telescope find_files<CR>",
    -- ["<leader>T"] = ":Telescope live_grep<CR>",
    -- mappings for the builtin lsp
    ["<leader>h"] = "<cmd>lua vim.lsp.buf.hover()<CR>",
    ["<leader>H"] = "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    ["<leader>d"] = "<cmd>lua vim.lsp.buf.definition()<CR>",
    ["<leader>D"] = "<cmd>lua vim.lsp.buf.declaration()<CR>",
    ["<leader>c"] = "<cmd>lua vim.lsp.buf.code_action()<CR>",
    ["<leader>C"] = "<cmd>lua vim.diagnostic.setloclist()<CR>",
    ["<leader>r"] = "<cmd>lua vim.lsp.buf.rename()<CR>",
    ["<leader>R"] = "<cmd>lua vim.lsp.buf.references()<CR>",
    ["<leader>n"] = "<cmd>lua vim.diagnostic.goto_prev()<CR>",
    ["<leader>N"] = "<cmd>lua vim.diagnostic.goto_next()<CR>",
    ["<leader>i"] = "<cmd>lua vim.lsp.buf.implementation()<CR>",
    ["<leader>f"] = "<cmd>lua vim.lsp.buf.format()<CR>",
  },
  visual_mode = {
    ["<C-z>"] = "<ESC>:w<CR>", -- write buffer to file
    ["p"] = '"_dP', -- paste without yanking the replaced selection
    -- persistent indent mode
    ["<"] = "<gv",
    [">"] = ">gv",
    -- move the selected line(s) or block of characters up or down
    ["<A-j>"] = ':move ">+1<CR>gv-gv',
    ["<A-k>"] = ':move "<-2<CR>gv-gv',
  },
  visual_block_mode = {
    ["<C-z>"] = "<ESC>:w<CR>", -- write buffer to file
    -- move the selected line(s) or block of characters up or down
    ["<A-j>"] = ':move ">+1<CR>gv-gv',
    ["<A-k>"] = ':move "<-2<CR>gv-gv',
  },
  command_mode = {},
  term_mode = {
    -- terminal navigation inside neovim
    ["<C-h>"] = "<C-\\><C-N><C-w>h",
    ["<C-j>"] = "<C-\\><C-N><C-w>j",
    ["<C-k>"] = "<C-\\><C-N><C-w>k",
    ["<C-l>"] = "<C-\\><C-N><C-w>l",
  },
}

local opts = { noremap = true, silent = true }

local mode_opts = {
  insert_mode = opts,
  normal_mode = opts,
  visual_mode = opts,
  visual_block_mode = opts,
  command_mode = opts,
  term_mode = { silent = true },
}

local mode_adapters = {
  insert_mode = "i",
  normal_mode = "n",
  visual_mode = "v",
  visual_block_mode = "x",
  command_mode = "c",
  term_mode = "t",
}

-- helper function to set individual keymaps
-- @param mode - the value corresponding to one of the keys in mode_adapters
-- @param key - the keyboard key to bind
-- @param val - a mapping or a tuple of mapping and user defined opt
-- @param opt - the options to pass
local function set_keymaps(mode, key, val, opt)
  if type(val) == "table" then
    opt = val[1]
    val = opt[2]
  end
  if val then
    vim.api.nvim_set_keymap(mode, key, val, opt)
  else
    pcall(vim.api.nvim_del_keymap, mode, key)
  end
end

set_keymaps("", "<C-z>", "<Nop>", opts) -- unset ctrl-z (suspend nvim)
set_keymaps("", "<Space>", "<Nop>", opts) -- unset the space key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- load the mappings for each mode
for mode, mappings in pairs(keymaps) do
  local opt = mode_opts[mode] or opts
  for key, value in pairs(mappings) do
    set_keymaps(mode_adapters[mode], key, value, opt)
  end
end
