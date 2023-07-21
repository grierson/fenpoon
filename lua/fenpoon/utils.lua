-- [nfnl] Compiled from fnl/fenpoon/utils.fnl by https://github.com/Olical/nfnl, do not edit.
local nfnl = require("nfnl.core")
local Path = require("plenary.path")
local function contains(coll, target)
  local function _1_(v)
    if (v == target) then
      return v
    else
      return nil
    end
  end
  return nfnl.some(_1_, coll)
end
local function project_path()
  return vim.loop.cwd()
end
local function normalize_path(item, _3fproj)
  return Path:new(item):make_relative((_3fproj or project_path()))
end
local function current_file_path()
  return vim.api.nvim_buf_get_name(0)
end
return {contains = contains, ["project-path"] = project_path, ["normalize-path"] = normalize_path, ["current-file-path"] = current_file_path}
