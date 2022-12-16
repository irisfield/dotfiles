local plugins = {
  -- allows packer to update itself
  { "wbthomason/packer.nvim" },

  -- colorscheme
  { "folke/tokyonight.nvim" },

  -- library of lua functions needed by many plugins
  -- { "nvim-lua/plenary.nvim" },

  -- shows indentation guides (vertical lines)
  { "lukas-reineke/indent-blankline.nvim" },

  -- git integrations in the buffer
  { "lewis6991/gitsigns.nvim",
    event = "BufReadPost",
    config = function() require("iris.config.gitsigns") end,
  },

  -- auto inserts or deletes corresponding pairs: ({["'<
  -- { "windwp/nvim-autopairs" },

  -- highlighter for color codes
  -- { "norcalli/nvim-colorizer.lua" }

  -- terminal
  -- { "akinsho/toggleterm.nvim" },

  -- fuzzy finder
  -- { "nvim-telescope/telescope.nvim" },

  -- statusline
  -- { "nvim-lualine/lualine.nvim",
  --   config = function() require("iris.config.lualine") end,
  --   require = { "kyazdani42/nvim-web-devicons", opt = true } -- collection of icons
  -- },

  -- file explorer inside neovim
  { "kyazdani42/nvim-tree.lua",
    cmd = "NvimTreeToggle",
    config = function() require("iris.config.nvim-tree") end,
  },

  -- pictograms for neovim built-in lsp
  { "onsails/lspkind-nvim", event = "InsertEnter" },

  -- snippet engine
  { "L3MON4D3/LuaSnip", after = "lspkind-nvim" },

  -- preconfigured snippets for different programming languages
  -- { "rafamadriz/friendly-snippets" },

  -- auto-completion engine
  { "hrsh7th/nvim-cmp",
    -- after = "LuaSnip",
    event = "InsertCharPre",
    config = function() require("iris.config.nvim-cmp") end,
  },

  -- auto-completion sources
  { "hrsh7th/cmp-path", after = "nvim-cmp" }, -- for system paths
  { "hrsh7th/cmp-buffer", after = "nvim-cmp" }, -- for items in the buffer
  { "hrsh7th/cmp-nvim-lsp", after = "nvim-cmp" }, -- for the builtin lsp client
  { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" }, -- for items from the lua api
  { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" }, -- for snippets from luasnip
  -- { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" }, -- for code signatures

  -- better code commenting
  { "numtoStr/Comment.nvim",
    event = "CursorHold",
    config = function() require("Comment").setup() end,
  },

  -- better syntax highlighting
  { "nvim-treesitter/nvim-treesitter",
    event = "BufWinEnter",
    run = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
  },

  -- context aware commentstring
  { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },

  -- { -- makes it easier to setup LSP functionalities for many languages
  --   "VonHeikemen/lsp-zero.nvim",
  --   requires = {
  --     -- support for language server protocol
  --     { "williamboman/mason.nvim" }, -- package manager for LSP related features in neovim
  --     { "williamboman/mason-lspconfig.nvim" }, -- makes it easier to use mason and lspconfig
  --     { "neovim/nvim-lspconfig" }, -- configurations for the builtin LSP client
  --     { "jose-elias-alvarez/null-ls.nvim" }, -- formatters and linters for neovim
  --     { "jayp0521/mason-null-ls.nvim" }, -- makes it easier to use mason and null-ls
  --     { "mfussenegger/nvim-dap" }, -- debug adapter for neovim
  --     { "jayp0521/mason-nvim-dap.nvim" }, -- makes it easier to use mason and nvim-dap


  --   },
  -- },
}

local ensure_packer = function()
  local repo = "https://github.com/wbthomason/packer.nvim"
  local path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if vim.fn.empty(vim.fn.glob(path)) > 0 then
    vim.api.nvim_echo({{ "Installing packer.nvim", "Type" }}, true, {})
    vim.fn.system({"git", "clone", "--depth", "1", repo, path})
    vim.api.nvim_command("packadd packer.nvim")
    return true, require("packer")
  else
    return false, require("packer")
  end
end

local bootstrapped, packer = ensure_packer()

-- compile packer whenever this file is written
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("packer_auto_compile", { clear = true }),
  pattern = "*/nvim/lua/*/plugins.lua",
  callback = function(ctx)
    vim.api.nvim_command("source " .. ctx.file)
    vim.api.nvim_command("PackerCompile")
  end,
})

return packer.startup({function(use)
  for _, plugin in ipairs(plugins) do
    use(plugin) -- load plugins
  end
  if bootstrapped then
    packer.sync() -- install plugins if packer bootstrapped
  end
end,
config = {
  max_jobs = 15, -- limit the number of simultaneous jobs
  compile_path = vim.fn.stdpath("data") .. "/site/pack/packer/packer_compiled.lua",
  display = {
    -- open a popup window for packer's display
    -- open_fn = function() require("packer.util").float({ border = "rounded" }) end,
    open_fn = require("packer.util").float,
  },
  git = {
    subcommands = {
      -- more efficient than packer's default
      fetch = "fetch --no-tags --no-recurse-submodules --update-shallow --progress",
    },
  },
}
})
