-- [[ Lsp-config ]]
-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- Mason will automatically install packages defined here
return {
	-- c++
	clangd = {},
	cmake = {
		filetypes = { 'cmake', 'CMakeLists.txt' },
	},

	-- go
	-- gopls = {}, -- trouble installing

	-- python
	jedi_language_server = {},
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

	-- other
	slint_lsp = {},
	matlab_ls = {},
	julials = {},
	jdtls = {},
}
