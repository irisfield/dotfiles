local cfound, comment = pcall(require, "Comment")
local tfound, tscc = pcall(require, "ts_context_commentstring.utils")

if not cfound or not tfound then
  return
end

comment.setup {
  pre_hook = function(ctx)
    local U = require("Comment.utils")
    local location = nil
    if ctx.ctype == U.ctype.block then
      location = tscc.get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = tscc.get_visual_start_location()
    end

    return require("ts_context_commentstring.internal").calculate_commentstring {
      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
      location = location,
    }
  end,
}
