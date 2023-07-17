-- [nfnl] Compiled from fnl/telescope/_extensions/fenpoon.fnl by https://github.com/Olical/nfnl, do not edit.
local telescope = require("telescope")
local api = require("fenpoon.api")
return telescope.register_extension({exports = {fenpoon = api.list}})
