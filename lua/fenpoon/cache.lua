-- [nfnl] Compiled from fnl/fenpoon/cache.fnl by https://github.com/Olical/nfnl, do not edit.
local nfnl = require("nfnl.core")
local utils = require("fenpoon.utils")
local cache = (vim.fn.stdpath("data") .. "/fenpoon.json")
local function read_state()
  local json = nfnl.slurp(cache)
  if nfnl["empty?"](json) then
    return {}
  else
    local state = vim.fn.json_decode(json)
    if nfnl["empty?"](json) then
      return {}
    else
      return state
    end
  end
end
local function read_marks(_3fproj_path)
  local state = read_state()
  local project = (_3fproj_path or utils["project-path"]())
  local marks
  do
    local t_3_ = state
    if (nil ~= t_3_) then
      t_3_ = (t_3_)[project]
    else
    end
    marks = t_3_
  end
  if (nil == marks) then
    return {}
  else
    return marks
  end
end
local function write(state)
  nfnl.spit(cache, vim.fn.json_encode(state))
  return read_marks()
end
return {["read-state"] = read_state, ["read-marks"] = read_marks, write = write}
