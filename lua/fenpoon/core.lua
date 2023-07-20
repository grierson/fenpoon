-- [nfnl] Compiled from fnl/fenpoon/core.fnl by https://github.com/Olical/nfnl, do not edit.
local nfnl = require("nfnl.core")
local str = require("nfnl.string")
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
local function add(marks, file)
  if contains(marks, file) then
    return marks
  else
    table.insert(marks, file)
    return marks
  end
end
local function remove(marks, target)
  local function _4_(v)
    if (v ~= target) then
      return v
    else
      return nil
    end
  end
  return nfnl.filter(_4_, marks)
end
local function relative_path(proj, file)
  return nfnl.second(str.split(file, proj))
end
local function entry_maker(file)
  return {value = file, ordinal = file, display = relative_path(project_path(), file), filename = file}
end
return {contains = contains, add = add, remove = remove}
