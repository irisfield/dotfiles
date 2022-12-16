local plugins = {
  { "wbthomason/packer.nvim" }, -- allows packer to update itself
  { "nvim-lua/plenary.nvim" }, -- library of lua functions needed by many plugins
  { "folke/tokyonight.nvim" }, -- colorscheme { "windwp/nvim-autopairs" }, -- auto inserts or deletes corresponding pairs: ({["'<
  { "lewis6991/gitsigns.nvim" }, -- git integrations for buffer
  { "lukas-reineke/indent-blankline.nvim" }, -- shows indentation guides (vertical lines)
  -- { "akinsho/toggleterm.nvim" }, -- terminal
  -- { "nvim-telescope/telescope.nvim" }, -- fuzzy finder
  -- { "norcalli/nvim-colorizer.lua" } -- high-performance color highlighter

  { -- file explorer inside neovim
    "kyazdani42/nvim-tree.lua",
    opt = true,
    cmd = "NvimTreeToggle",
    config = function() require("setup.nvim_tree") end,
    requires = { "kyazdani42/nvim-web-devicons", opt = true }, -- collection of icons
  },

  { -- shortcuts for commenting code
    -- "numtoStr/Comment.nvim",
    "terrortylor/nvim-comment",
    requires = {
      "JoosepAlviste/nvim-ts-context-commentstring", -- context aware commentstring
    },
  },

  { -- syntax highlighting
    "nvim-treesitter/nvim-treesitter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  },

  { -- makes it easier to setup LSP functionalities for many languages
    "VonHeikemen/lsp-zero.nvim",
    requires = {
      -- support for language server protocol
      { "williamboman/mason.nvim" }, -- package manager for LSP related features in neovim
      { "williamboman/mason-lspconfig.nvim" }, -- makes it easier to use mason and lspconfig
      { "neovim/nvim-lspconfig" }, -- configurations for the builtin LSP client
      { "jose-elias-alvarez/null-ls.nvim" }, -- formatters and linters for neovim
      { "jayp0521/mason-null-ls.nvim" }, -- makes it easier to use mason and null-ls
      { "mfussenegger/nvim-dap" }, -- debug adapter for neovim
      { "jayp0521/mason-nvim-dap.nvim" }, -- makes it easier to use mason and nvim-dap

      -- snippets
      { "L3MON4D3/LuaSnip" }, -- snippet engine
      { "rafamadriz/friendly-snippets" }, -- preconfigured snippets for different programming languages

      -- completions
      { "hrsh7th/nvim-cmp" }, -- the completion engine
      { "hrsh7th/cmp-path" }, -- completion source for system paths
      { "hrsh7th/cmp-buffer" }, -- completion source for the buffer
      { "hrsh7th/cmp-nvim-lsp" }, -- completion source for the builtin LSP client
      { "hrsh7th/cmp-nvim-lua" }, -- completion source for the Lua API in neovim
      { "saadparwaiz1/cmp_luasnip" }, -- completion source for LuaSnip
      { "hrsh7th/cmp-nvim-lsp-signature-help" }, -- completion source for signatures
    },
  },
}

local pfound, pack = pcall(require, "iris.packer")
if not pfound then return end

return pack.packer.startup(function(use)
  for _, plugin in ipairs(plugins) do
    use(plugin)
  end
  if pack.bootstrap then
    pack.packer.sync()
    print("Please restart neovim for changes to take effect.")
    vim.wait(3000)
  end
end)
