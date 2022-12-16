-- custom filetypes
vim.filetype.add({
  extension = {
    csv = "conf",
    -- conf = "conf",
  },
  pattern = {
    ["ignore$"] = "conf",
  },
  filename = {
    -- [""] = "",
  },
})

-- vim.cmd([[
-- augroup highlight_yank
--   autocmd!
--   au TextYankPost * silent! lua require("vim.highlight").on_yank({higroup = "Search", timeout = 500})
-- augroup END
-- ]])
local iris = vim.api.nvim_create_augroup("iris", { clear = true })

-- highlight the region on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = iris,
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 400 })
    end,
})

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

-- turns off highlighting on the bits of code that are changed,
-- so the line that is changed is highlighted but the actual text
-- that has changed stands out on the line and is readable
vim.cmd([[
if &diff
    highlight! link DiffText MatchParen
endif
]])

-- restore blinking beam cursor after exiting neovim
vim.cmd([[
augroup RestoreCursorShapeOnExit
    autocmd!
    autocmd VimLeave * set guicursor=a:ver20-blinkwait175-blinkoff150-blinkon175
augroup END
]])
