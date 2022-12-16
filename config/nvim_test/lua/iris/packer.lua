local pfound, packer = pcall(require, "packer")
local packer_installed = false

if not pfound then
  packer_installed = vim.fn.system({
    "git", "-C", vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim",
    "clone", "--depth", "1", "--single-branch", "--no-tags",
    "https://github.com/wbthomason/packer.nvim"
  })
  vim.api.nvim_command("packadd packer.nvim")
  return
end

-- compile packer upon writing the 'plugins.lua' file
vim.cmd([[
augroup packer_user_config
  autocmd!
  autocmd BufWritePost plugins.lua source <afile> | PackerCompile
augroup end
]])

-- packer configuration
packer.init({
  compile_path = vim.fn.stdpath("data") .. "/site/pack/packer/packer_compiled.lua",
  max_jobs = 25, -- limit the number of simultaneous jobs
  git = {
    subcommands = {
      -- more efficient than packer's default
      fetch = "fetch --no-tags --no-recurse-submodules --update-shallow --progress",
    },
  },
  display = {
    open_fn = function()
      -- open a popup window for packer's display
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return {
  packer = packer,
  bootstrap = packer_installed,
}
