local colorscheme = "tokyonight-night"

if not pcall(vim.api.nvim_command, "colorscheme " .. colorscheme) then
  vim.api.nvim_command("colorscheme habamax")
end
