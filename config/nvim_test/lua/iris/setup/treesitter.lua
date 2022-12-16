local tfound, treesitter = pcall(require, "nvim-treesitter.configs")

if not tfound then
  return
end

-- (https://github.com/nvim-treesitter/nvim-treesitter#supported-languages)
treesitter.setup({
  ensure_installed = {
    "lua",
    "java",
    "html",
    "make",
    "toml",
    "yaml",
    "json",
    "bash",
    "rust",
    "python",
    "kotlin",
    "comment",
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
