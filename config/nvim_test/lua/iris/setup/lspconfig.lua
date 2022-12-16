local lfound, lspconfig = pcall(require, "lspconfig")

if not lfound then
  return
end

-- server-specific settings
-- (https://github.com/neovim/nvim-lspconfig#quickstart)
-- (https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md)

-- preferred settings for sumneko_lua
lspconfig.sumneko_lua.setup({
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }, -- get the language server to recognize the `vim` global
      },
      workspace = {
        library = {
          -- make the server aware of the following paths
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
      telemetry = { enable = false },
    },
  },
})

-- preferred settings for pyright
lspconfig.pyright.setup({
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
  single_file_support = true,
})

-- preferred settings for rust-analyzer
lspconfig.rust_analyzer.setup({
  -- rust-tools.nvim options
  tools = {
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },
  -- these override the defaults set by rust-tools.nvim
  settings = {
    ["rust-analyzer"] = {
      -- enable clippy on save
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})
