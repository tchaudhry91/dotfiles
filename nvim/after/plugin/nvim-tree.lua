vim.g.loaded_netwr = 1
vim.g.loaded_netwrPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require('nvim-tree').setup {
  sort_by = 'case_sensitive',
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
}
