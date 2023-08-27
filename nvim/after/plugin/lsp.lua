local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
	lsp.default_keymaps({ buffer = bufnr })
	vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { buffer = true })
end)

lsp.format_on_save({
	format_opts = {
		async = false,
		timeout_ms = 10000,
	},
	servers = {
		['rust_analyzer'] = { 'rust' },
		['lua_ls'] = { 'lua' },
		['black'] = { 'python' },
		['gopls'] = { 'go' },
		['svelte'] = { 'svelte' },
	}
})

require("lspconfig").rust_analyzer.setup {
	settings = {
		['rust-analyzer'] = {
			checkOnSave = {
				allFeatures = true,
				overrideCommand = {
					'cargo', 'clippy', '--workspace', '--message-format=json',
					'--all-targets', '--all-features'
				}
			}
		}
	}
}

lsp.setup()

-- Make sure you setup `cmp` after lsp-zero

local cmp = require('cmp')

cmp.setup({
	preselect = 'item',
	completion = {
		completeopt = 'menu,menuone,noinsert'
	},
	mapping = {
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		['<C-Space>'] = cmp.mapping.complete(),
	}
})

local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		require("null-ls").builtins.formatting.prettierd,
	},
})
