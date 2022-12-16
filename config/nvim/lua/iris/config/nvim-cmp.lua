local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

-- needed to load vscode style snippets
require("luasnip/loaders/from_vscode").lazy_load()

luasnip.config.set_config({
  region_check_events = "InsertEnter",
  delete_check_events = "InsertLeave",
})

-- needed to ensure super tab works as intended
local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- for luasnip
    end,
  },
  mapping = {
    -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
    ["<C-j>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-k>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
    -- disables the <C-y> mapping
    ["<C-y>"] = cmp.config.disable,
    ["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
    -- setting select to false will only confirm explicitly selected items
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
    -- super tab
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s", }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s", }),
  },
  formatting = {
    -- fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = {
        nvim_lsp = "[LSP]",
        luasnip = "[Snip]",
        path = "[Path]",
        buffer = "[Buffer]",
        nvim_lua = "[Lua]",
      },
    }),
  },
  sources = {
    -- this order affects the order of the results
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer", keyword_length = 2 },
    { name = "nvim_lsp_signature_help" }
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  experimental = {
    ghost_text = true, -- grayed out text from auto suggestion
    native_menu = false,
  },
})
