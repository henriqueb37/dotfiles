-- Adds prefixes to WhichKey when using lazy loading

local M = {}

M.prefixes = {}

---@param prefix string The key you want to use as prefix
---@param name string The name of the prefix
function M.add(prefix, name)
  M.prefixes[prefix] = name
  if package.loaded['which-key'] then
    M.register()
  end
end

function M.format_prefixes()
  local prefs = {}
  for k, v in pairs(M.prefixes) do
    table.insert(prefs, { k, group = v })
  end
  return prefs
end

-- Should be called right after WhichKey's setup
function M.register()
  require('which-key').add(M.format_prefixes())
end

return M
