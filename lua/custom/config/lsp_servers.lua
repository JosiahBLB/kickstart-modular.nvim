-- [[ Lsp-config ]]
-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

return {
	-- c++
	clangd = {},
	cmake = {
		filetypes = { 'cmake', 'CMakeLists.txt' },
	},

	-- go
	-- gopls = {}, -- trouble installing

	-- python
	pyright = {},
	ruff_lsp = {},

	-- rust
	rust_analyzer = {},

	-- web dev
	cssls = {},
	tsserver = {},
	quick_lint_js = {},
	html = { filetypes = { 'html', 'twig', 'hbs' } },

	-- lua
	lua_ls = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
			-- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
			-- diagnostics = { disable = { 'missing-fields' } },
		},
	},

	-- data
	jsonls = {},
	dockerls = {},
	yamlls = {},

	-- spelling
	marksman = {},
	grammarly = {},
}
