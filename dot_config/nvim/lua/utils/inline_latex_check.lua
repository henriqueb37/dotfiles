local has_ts, ts = pcall(require, "vim.treesitter")

local M = {}

local ft_aliases = {
  markdown = 'markdown_inline'
}

local function get_node_at_cursor()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cursor_range = { cursor[1] - 1, cursor[2] - 1 }
  local buf = vim.api.nvim_get_current_buf()
  local filetype = ft_aliases[vim.filetype.match({ buf = buf })]
  local ok, parser = pcall(ts.get_parser, buf, filetype)
  if not ok or not parser then
    return
  end
  local root_tree = parser:parse()[1]
  local root = root_tree and root_tree:root()

  if not root then
    return
  end

  return root:named_descendant_for_range(cursor_range[1], cursor_range[2], cursor_range[1], cursor_range[2])
end

function M.check_at_cursor()
  local node = get_node_at_cursor()
  local node_path = node and "" or "none"
  while node do
    local type = node:type()
    node_path = node_path .. '/' .. type
    if type == "latex_block" or type == "displayed_equation" then
      return true
    end
    node = node:parent()
  end
  return false
end

return M
