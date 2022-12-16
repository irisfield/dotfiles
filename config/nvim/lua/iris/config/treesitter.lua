-- (https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)
require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua",
    "json",
    "bash",
    "rust",
    "python",
    -- "comment",
    "markdown",
    "gitignore",
    "git_rebase",
    "gitattributes",
  },
  auto_install = true, -- automatically install missing parsers when entering buffer
  ignore_install = { "" }, -- list of parsers not to install
  autopairs = { enable = true },
  highlight = {
    enable = true, -- enable the extension
    disable = { "" }, -- list of languages to exclude from treesitter
  },
  indent = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false, -- disable the CursorHold autocommand
  },
})
