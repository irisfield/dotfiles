local cfound, comment = pcall(require, "nvim_comment")
local tfound, tscc = pcall(require, "ts_context_commentstring.internal")

if not cfound or not tfound then
  return
end

-- (https://github.com/JoosepAlviste/nvim-ts-context-commentstring#nvim-comment)

comment.setup {
  -- hook function to call before commenting takes place
  hook = function()
    tscc.update_commentstring()
  end,
}
