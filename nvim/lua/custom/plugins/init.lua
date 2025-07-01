-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  'nvim-tree/nvim-tree.lua',
  'akinsho/toggleterm.nvim',
  'ThePrimeagen/harpoon',
  'folke/trouble.nvim',
  'christoomey/vim-tmux-navigator',
  'folke/zen-mode.nvim',
  {
    'olimorris/codecompanion.nvim',
    opts = {},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
}
