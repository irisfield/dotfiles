local ifound, indent_blankline = pcall(require, "indent_blankline")

if not ifound then
  return
end

-- (https://github.com/lukas-reineke/indent-blankline.nvim)
indent_blankline.setup({
  show_current_context = true,
  show_current_context_start = false,
})
