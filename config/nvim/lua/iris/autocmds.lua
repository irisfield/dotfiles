local autocommands = {
  lazy_load_plugins = {
    desc = "compile packer so that plugins can be lazy loaded",
    event = { "VimEnter" },
    pattern = "*",
    callback = function()
      vim.api.nvim_command("PackerCompile")
    end,
  },
  highlight_yank = {
    desc = "temporarily highlight yanked text",
    event = { "TextYankPost" },
    pattern = "*",
    callback = function()
      vim.highlight.on_yank({ higroup = "Visual", timeout = 300 })
    end,
  },
  restore_cursor_shape = {
    desc = "restore blinking cursor beam upon exiting neovim",
    event = { "VimLeave" },
    pattern = "*",
    command = "set guicursor=a:ver20-blinkwait175-blinkoff150-blinkon175",
  },
}

-- create autocommands
for group, values in pairs(autocommands) do
  vim.api.nvim_create_autocmd(values["event"], {
    desc = values["desc"],
    buffer = values["buffer"], -- cannot be used with pattern
    pattern = values["pattern"],
    command = values["command"], -- cannot be used with callback
    callback = values["callback"],
    group = vim.api.nvim_create_augroup(group, { clear = true }),
  })
end

-- store cursor position
-- remove trailing whitespaces except in '.md' files
-- remove trailing new lines at the end of file
-- replace trailing newlines with one newline in '.c' or '.h' files
-- restore cursor position
vim.cmd([[
autocmd BufWritePre * let currPos = getpos(".")
autocmd BufWritePre *[^m][^d] %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])
]])

-- custom filetypes
vim.filetype.add({
  extension = {
    csv = "conf",
    zsh = "bash",
    -- conf = "conf",
  },
  pattern = {
    ["ignore$"] = "conf",
  },
  filename = {
    -- [""] = "",
  },
})
