-- For available settings, please refer to:
-- (https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pyright)
return {
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off",
      },
    },
  },
}
