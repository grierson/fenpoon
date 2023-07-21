-- [nfnl] Compiled from fnl/spec/nfnl/fenpoon/core_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local core = require("fenpoon.core")
local function _2_()
  local proj = "proj/foo/"
  local function _3_()
    local state = {}
    local file = "bar.fnl"
    local file_path = (proj .. file)
    local expected = {[proj] = {{id = 1, file = file}}}
    local new_state = core.add(state, file_path, proj)
    return assert.are.same(expected, new_state)
  end
  it("add first mark", _3_)
  local function _4_()
    local file = "bar.fnl"
    local state = {[proj] = {{id = 1, file = file}}}
    local file_path = (proj .. file)
    local new_state = core.add(state, file_path, proj)
    return assert.are.same(state, new_state)
  end
  it("idempotent - same file not added twice", _4_)
  local function _5_()
    local file = "second.fnl"
    local file_path = (proj .. file)
    local state = {[proj] = {{id = 1, file = "bar.fnl"}}}
    local expected = {[proj] = {{id = 1, file = "bar.fnl"}, {id = 2, file = file}}}
    local new_state = core.add(state, file_path, proj)
    return assert.are.same(expected, new_state)
  end
  it("add second mark", _5_)
  local function _6_()
    local file_path = "proj/foo/bar.fnl"
    local state = {[proj] = {{id = 2, file = "baz.fnl"}}}
    local expected = {[proj] = {{id = 2, file = "baz.fnl"}, {id = 1, file = "bar.fnl"}}}
    local new_state = core.add(state, file_path, proj)
    return assert.are.same(expected, new_state)
  end
  it("earliest id is used", _6_)
  local function _7_()
    local new_proj = "proj/bar/"
    local file = "second.fnl"
    local existing_mark = {id = 1, file = "foo.fnl"}
    local file_path = (new_proj .. file)
    local state = {[proj] = {existing_mark}}
    local expected = {[proj] = {existing_mark}, [new_proj] = {{id = 1, file = file}}}
    local new_state = core.add(state, file_path, new_proj)
    return assert.are.same(expected, new_state)
  end
  return it("add second project mark", _7_)
end
describe("add test", _2_)
local function _8_()
  local proj = "proj/foo/"
  local function _9_()
    local id = 1
    local state = {[proj] = {{id = id, file = "bar.fnl"}}}
    local expected = {[proj] = {}}
    local actual = core.remove(state, id, proj)
    return assert.are.same(expected, actual)
  end
  it("remove only file but keep project", _9_)
  local function _10_()
    local id = 1
    local keep_file = {id = 2, file = "bar.fnl"}
    local state = {[proj] = {{id = id, file = "foo.fnl"}, keep_file}}
    local expected = {[proj] = {keep_file}}
    local actual = core.remove(state, id, proj)
    return assert.are.same(expected, actual)
  end
  return it("remove second file in project", _10_)
end
describe("remove-mark test", _8_)
local function _11_()
  local function _12_()
    local id = 1
    local mark = {id = id, file = "foo.fnl"}
    local marks = {mark, {id = 2, file = "bar.fnl"}}
    local actual = core["get-mark-by-id"](marks, id)
    return assert.are.same(mark, actual)
  end
  return it("find mark by id", _12_)
end
return describe("get-mark-by-id test", _11_)
