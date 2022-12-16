-- load settings
require("iris.options")
require("iris.keymaps")
require("iris.autocmds")
require("iris.plugins")
require("iris.colorscheme")

-- load plugins
-- require("iris.setup.comment")
-- require("iris.setup.lsp_zero")
-- require("iris.setup.lspconfig")
-- require("iris.setup.nvim_tree")
-- require("iris.setup.autopairs")
-- require("iris.setup.treesitter")
-- require("iris.setup.completion")
-- require("iris.setup.gitsigns")
-- require("iris.setup.indent_blankline")

-- lazy load plugins and setup
-- vim.api.nvim_create_autocmd("BufWinEnter", {
--     group = vim.api.nvim_create_augroup("lazy_load_first", { clear = true }),
--     callback = function()
--       require("iris.plugins")
--       require("iris.setup.treesitter")
--     end,
-- })
--
-- vim.api.nvim_create_autocmd("CursorHold", {
--     group = vim.api.nvim_create_augroup("lazy_load_second", { clear = true }),
--     callback = function()
--       require("iris.setup.lsp_zero")
--       require("iris.setup.lspconfig")
--       require("iris.setup.nvim_tree")
--     end,
-- })
--
-- vim.api.nvim_create_autocmd("CursorMoved", {
--     group = vim.api.nvim_create_augroup("lazy_load_third", { clear = true }),
--     callback = function()
--       require("iris.setup.comment")
--       require("iris.setup.gitsigns")
--       require("iris.setup.indent_blankline")
--     end,
-- })
--
-- vim.api.nvim_create_autocmd("InsertEnter", {
--     group = vim.api.nvim_create_augroup("lazy_load_fourth", { clear = true }),
--     callback = function()
--       require("iris.setup.autopairs")
--     end,
-- })
--
-- vim.api.nvim_create_autocmd("InsertCharPre", {
--     group = vim.api.nvim_create_augroup("lazy_load_fifth", { clear = true }),
--     callback = function()
--       require("iris.setup.completion")
--     end,
-- })
