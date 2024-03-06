local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


local plugins = {
	"folke/tokyonight.nvim",
	'nvim-lua/plenary.nvim',
	{ 'nvim-telescope/telescope.nvim',     dependencies = { "nvim-lua/plenary.nvim" } },
	'ThePrimeagen/harpoon',
	'nvim-treesitter/nvim-treesitter',
	'akinsho/toggleterm.nvim',
	'mbbill/undotree',
	'github/copilot.vim',
	'nvim-tree/nvim-tree.lua',
	'nvim-tree/nvim-web-devicons',
	'christoomey/vim-tmux-navigator',
	'neovim/nvim-lspconfig',
	{ 'williamboman/mason.nvim',           lazy = false },
	{ 'williamboman/mason-lspconfig.nvim', lazy = false },
	'hrsh7th/nvim-cmp',
	'hrsh7th/cmp-nvim-lsp',
	'L3MON4D3/LuaSnip',
}

require("lazy").setup(plugins, {})
