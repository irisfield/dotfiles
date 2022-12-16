local cfound, lsp_zero = pcall(require, "lsp-zero")
local ufound, mason = pcall(require, "mason")
local tfound, mason_lspconfig = pcall(require, "mason-lspconfig")
local ifound, null_ls = pcall(require, "null-ls")
local efound, mason_null_ls = pcall(require, "mason-null-ls")
local sfound, mason_dap = pcall(require, "mason-nvim-dap")

if not cfound or not ufound or not tfound or not ifound or not efound or not sfound then
  return
end

-- setup settings for each plugin
local mason_settings = {
  ui = { border = "rounded" },
}

local mason_lspconfig_settings = {
  -- (https://github.com/williamboman/mason-lspconfig.nvim#available-lsp-servers)
  ensure_installed = {
    "html",
    -- "jdtls",
    "jsonls",
    "yamlls",
    "bashls",
    "pyright",
    -- "gradle_ls",
    "remark_ls",
    "sumneko_lua",
    "rust_analyzer",
    "kotlin_language_server",
  },
  automatic_installation = true,
}
local mason_null_ls_settings = {
  ensure_installed = {
    "black",
    "stylua",
  },
  automatic_installation = true,
}

local mason_dap_settings = {
  ensure_installed = {
    "python",
    -- "javadbg",
  },
  automatic_setup = true,
}

local null_ls_settings = {
  debug = false,
  sources = {
    null_ls.builtins.formatting.black.with({ extra_args = {
      "--line-length", "120",
    }}),
    null_ls.builtins.formatting.stylua.with({ extra_args = {
      "--indent-type", "spaces",
      "--indent-width", vim.api.nvim_buf_get_option(0, "shiftwidth"),
    }}),
    null_ls.builtins.formatting.prettier.with({ extra_args = {
      "--no-semi",
      "--single-quote",
      "--jsx-single-quote",
    }}),
    null_ls.builtins.diagnostics.flake8.with({ extra_args = {
      -- https://pycodestyle.pycqa.org/en/latest/intro.html#error-codes
      "--max-line-length", "120",
      "--ignore", "W391,E302,E301",
    }}),
  },
}

-- (https://github.com/VonHeikemen/lsp-zero.nvim/blob/main/advance-usage.md)

lsp_zero.preset("recommended")
lsp_zero.set_preferences({
  -- (https://github.com/VonHeikemen/lsp-zero.nvim#choose-your-features)
  call_servers = "local", -- setup one of the supported installers
  manage_nvim_cmp = false, -- configure keybindings and completion sources for 'nvim-cmp'
  set_lsp_keymaps = false, -- add keybindings to a buffer with a language server attached
  cmp_capabilities = true, -- tell the language servers what capabilities 'nvim-cmp' supports
  suggest_lsp_servers = true, -- suggest to install a lsp servers when you encounter a new filetype
  configure_diagnostics = true, -- change the way error messages are shown using 'vim.diagnostic.config'
  setup_servers_on_start = true, -- initialize all installed servers on startup
  sign_icons = {
    warn = "",
    hint = "",
    info = "",
    error = "",
  },
})

-- configure on_attach settings
lsp_zero.on_attach(function(client, bufnr)
  -- mappings for the builtin lsp
  local noremap = { buffer = bufnr, remap = true, silent = true }
  vim.keymap.set("n", "<leader>h", "<cmd>lua vim.lsp.buf.hover()<CR>", noremap)
  vim.keymap.set("n", "<leader>H", "<cmd>lua vim.lsp.buf.signature_help()<CR>", noremap)
  vim.keymap.set("n", "<leader>d", "<cmd>lua vim.lsp.buf.definition()<CR>", noremap)
  vim.keymap.set("n", "<leader>D", "<cmd>lua vim.lsp.buf.declaration()<CR>", noremap)
  vim.keymap.set("n", "<leader>c", "<cmd>lua vim.lsp.buf.code_action()<CR>", noremap)
  vim.keymap.set("n", "<leader>C", "<cmd>lua vim.diagnostic.setloclist()<CR>", noremap)
  vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>", noremap)
  vim.keymap.set("n", "<leader>R", "<cmd>lua vim.lsp.buf.references()<CR>", noremap)
  vim.keymap.set("n", "<leader>n", "<cmd>lua vim.diagnostic.goto_prev()<CR>", noremap)
  vim.keymap.set("n", "<leader>N", "<cmd>lua vim.diagnostic.goto_next()<CR>", noremap)
  vim.keymap.set("n", "<leader>i", "<cmd>lua vim.lsp.buf.implementation()<CR>", noremap)
  vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>", noremap)

  -- highlight hovered word (not working)
  if client.server_capabilities.documentHighlightProvider then
  vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
  vim.api.nvim_clear_autocmds { buffer = bufnr, group = "lsp_document_highlight" }
  vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "highlight documents on CursorHold",
  })
  vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "clear all the references on CursorMoved",
  })
  end
end)

-- setup
lsp_zero.setup()
mason.setup(mason_settings)
null_ls.setup(null_ls_settings) -- must be setup after mason
mason_lspconfig.setup(mason_lspconfig_settings) -- must be setup after mason
mason_null_ls.setup(mason_null_ls_settings) -- must be setup after null-ls
mason_dap.setup(mason_dap_settings) -- must be setup after mason

-- additional configurations after setup
vim.diagnostic.config({
  underline = true, -- underline the text with diagnostic errors
  virtual_text = false, -- disable in-line diagnostic (prefer as floating window)
  severity_sort = true, -- sort diagnostics by severities (higher severities are displayed first)
  update_in_insert = true, -- update diagnostics in insert mode
})

-- show diagnostic window on CursorHold
vim.cmd([[autocmd CursorHold <buffer> lua vim.diagnostic.open_float()]])
