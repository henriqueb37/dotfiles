return {
  'folke/snacks.nvim',
  enabled = true,
  priority = 1000,
  lazy = false,
  opts = {
    notify = { enabled = true, },
    bigfile = { enabled = true, },
    scroll = { enabled = false, },
    image = { enabled = false, },
    dashboard = {
      enabled = true,
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
  }
}
