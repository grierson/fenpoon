-- [nfnl] Compiled from fnl/spec/nfnl/fenpoon/core_spec.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("plenary.busted")
local describe = _local_1_["describe"]
local it = _local_1_["it"]
local assert = require("luassert.assert")
local core = require("fenpoon.core")
local function _2_()
  local function _3_()
    assert.are.same(core.contains({1, 2, 3}, 1), 1)
    assert.are.same(core.contains({1, 2, 3}, 2), 2)
    return assert.are.same(core.contains({"a", "b", "c"}, "a"), "a")
  end
  it("list contains value", _3_)
  local function _4_()
    assert.is_nil(core.contains({1, 2, 3}, 0))
    return assert.is_nil(core.contains({1, 2, 3}, 4), 2)
  end
  return it("list doesn't contains value", _4_)
end
describe("contains test", _2_)
local function _5_()
  local function _6_()
    return assert.are.same(core["get-ids"]({{id = 1}, {id = 2}}), {1, 2})
  end
  return it("list contains value", _6_)
end
describe("get-ids test", _5_)
local function _7_()
  local function _8_()
    local file1 = "a"
    local file2 = "b"
    return assert.are.same(core["get-files"]({{file = file1}, {file = file2}}), {file1, file2})
  end
  return it("list contains value", _8_)
end
describe("get-files test", _7_)
local function _9_()
  local function _10_()
    local target = 2
    local file1 = {id = 1, file = "a"}
    local file2 = {id = 2, file = "b"}
    return assert.are.same(core["find-mark-by-id"]({file1, file2}, target), file2)
  end
  return it("list contains value", _10_)
end
describe("find-mark-by-id test", _9_)
local function _11_()
  local function _12_()
    return assert.are.same(core["find-mark-index-by-id"]({{id = 1, file = "a"}, {id = 3, file = "b"}}, 3), 2)
  end
  return it("list contains value", _12_)
end
describe("find-mark-by-index test", _11_)
local function _13_()
  local function _14_()
    return assert.are.same(core["next-id"]({}), 1)
  end
  it("default to 1", _14_)
  local function _15_()
    return assert.are.same(core["next-id"]({1}), 2)
  end
  it("get next id after 1", _15_)
  local function _16_()
    return assert.are.same(core["next-id"]({2}), 1)
  end
  return it("get earliest id", _16_)
end
describe("next-id test", _13_)
local function _17_()
  local function _18_()
    local state = {}
    local file = "proj/foo/bar.fnl"
    local expected = {{id = 1, file = file}}
    core.add(state, file)
    return assert.are.same(expected, state)
  end
  it("file added", _18_)
  local function _19_()
    local state = {}
    local file = "proj/foo/bar.fnl"
    local expected = {{id = 1, file = file}}
    core.add(state, file)
    core.add(state, file)
    return assert.are.same(expected, state)
  end
  it("same file isn't added twice", _19_)
  local function _20_()
    local state = {}
    local file1 = "proj/foo/foo.fnl"
    local file2 = "proj/foo/bar.fnl"
    local expected = {{id = 1, file = file1}, {id = 2, file = file2}}
    core.add(state, file1)
    core.add(state, file2)
    return assert.are.same(expected, state)
  end
  it("second file added", _20_)
  local function _21_()
    local file2 = "bar.fnl"
    local state = {{id = 2, file = file2}}
    local file1 = "foo.fnl"
    local expected = {{id = 2, file = file2}, {id = 1, file = file1}}
    core.add(state, file1)
    return assert.are.same(expected, state)
  end
  return it("add mark into earlist index test", _21_)
end
describe("add test", _17_)
local function _22_()
  local function _23_()
    local id = 1
    local file = "proj/foo/bar.fnl"
    local state = {{id = id, file = file}}
    local expected = {}
    core.remove(state, id)
    return assert.are.same(expected, state, "File removed")
  end
  it("remove file", _23_)
  local function _24_()
    local file1 = {id = 1, file = "proj/foo/foo.fnl"}
    local file2 = {id = 2, file = "proj/foo/bar.fnl"}
    local file3 = {id = 3, file = "proj/foo/baz.fnl"}
    local state = {file1, file2, file3}
    local expected = {file1, file3}
    core.remove(state, 2)
    return assert.are.same(expected, state, "File removed")
  end
  return it("remove file in the middle", _24_)
end
return describe("remove-mark test", _22_)
