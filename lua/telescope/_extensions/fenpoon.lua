local _2afile_2a = "fnl/telescope/_extensions/fenpoon.fnl"
local telescope = require("telescope")
local api = require("fenpoon.api")
return telescope.register_extension({exports = {fenpoon = api.telescope}})