-- config/utils.lua - Shared utility functions

local M = {}

-- Simple JSON formatter in pure Lua
function M.format_json(obj, indent)
  indent = indent or 0
  local indent_str = string.rep("  ", indent)
  local next_indent = string.rep("  ", indent + 1)

  if type(obj) == "table" then
    if vim.islist(obj) then
      if #obj == 0 then
        return "[]"
      end
      local items = {}
      for _, v in ipairs(obj) do
        table.insert(items, next_indent .. M.format_json(v, indent + 1))
      end
      return "[\n" .. table.concat(items, ",\n") .. "\n" .. indent_str .. "]"
    else
      local keys = vim.tbl_keys(obj)
      if #keys == 0 then
        return "{}"
      end
      table.sort(keys)
      local items = {}
      for _, k in ipairs(keys) do
        table.insert(items, next_indent .. vim.json.encode(k) .. ": " .. M.format_json(obj[k], indent + 1))
      end
      return "{\n" .. table.concat(items, ",\n") .. "\n" .. indent_str .. "}"
    end
  elseif obj == vim.NIL then
    return "null"
  elseif type(obj) == "string" then
    return vim.json.encode(obj)
  elseif type(obj) == "number" or type(obj) == "boolean" then
    return tostring(obj)
  elseif obj == nil then
    return "null"
  else
    return vim.json.encode(obj)
  end
end

return M
