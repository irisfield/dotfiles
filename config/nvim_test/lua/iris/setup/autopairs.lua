local pfound, autopairs = pcall(require, "nvim-autopairs")

if not pfound then
  return
end

autopairs.setup({
  check_ts = true, -- use treesitter to check for a pair
  ts_config = {
    lua = { "string", "source" }, -- do not add pairs for these treesitter nodes
  },
})

-- custom rules
local rule = require("nvim-autopairs.rule")
local brackets = { { "(", ")" }, { "[", "]" }, { "{", "}" }, { "'", '"' } }

-- inserts a matching space after pressing the space key inside a pair
autopairs.add_rules({
  rule(" ", " "):with_pair(function(opts)
    local pair = opts.line:sub(opts.col - 1, opts.col)
    return vim.tbl_contains({
      brackets[1][1] .. brackets[1][2],
      brackets[2][1] .. brackets[2][2],
      brackets[3][1] .. brackets[3][2],
      brackets[4][1] .. brackets[4][1],
      brackets[4][2] .. brackets[4][2],
    }, pair)
  end)
})

-- hook autopairs into cmp
local cfound, cmp = pcall(require, "cmp")

if not cfound then
  return
end

local autopairs_cmp = require("nvim-autopairs.completion.cmp")

cmp.event:on("confirm_done", autopairs_cmp.on_confirm_done({ map_char = { tex = "" } }))
