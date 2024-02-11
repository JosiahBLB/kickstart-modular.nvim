-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = desc .. ' (LSP)'
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[r]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[a]ction')

  nmap('cd', require('telescope.builtin').lsp_definitions, '[d]efinition')
  nmap('cr', require('telescope.builtin').lsp_references, '[r]eferences')
  nmap('ci', require('telescope.builtin').lsp_implementations, '[i]mplementation')
  nmap('<leader>ctd', require('telescope.builtin').lsp_type_definitions, '[t]ype [D]efinition')
  nmap('<leader>cds', require('telescope.builtin').lsp_document_symbols, '[d]ocument [s]ymbols')
  nmap('<leader>cws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[w]orkspace [s]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('cD', vim.lsp.buf.declaration, '[d]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[w]orkspace [a]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[w]orkspace [r]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[w]orkspace [l]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[c]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[d]ebug', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[g]it', _ = 'which_key_ignore' },
  ['<leader>gh'] = { name = '[g]it [h]unk', _ = 'which_key_ignore' },
  ['<leader>gp'] = { name = '[g]it [p]review', _ = 'which_key_ignore' },
  ['<leader>gr'] = { name = '[g]it [r]eset', _ = 'which_key_ignore' },
  ['<leader>gs'] = { name = '[g]it [s]tage', _ = 'which_key_ignore' },
  ['<leader>gu'] = { name = '[g]it [u]ndo', _ = 'which_key_ignore' },
  ['<leader>gD'] = { name = '[g]it [D]iff', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[r]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[s]earch', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[t]oggle', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[w]orkspace', _ = 'which_key_ignore' },
}
-- register which-key VISUAL mode
-- required for visual <leader>hs (hunk stage) to work
require('which-key').register({
  ['<leader>'] = { name = 'VISUAL <leader>' },
  ['<leader>h'] = { 'Git [h]unk' },
}, { mode = 'v' })

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- [[ Custom additions ]]

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = require 'custom.config.lsp_servers'
-- require('lspconfig').ccls.setup {} -- TODO: you will have to manually install this

-- add vim support for *.slint
vim.cmd 'autocmd BufRead,BufNewFile *.slint set filetype=slint'

-- [[ /Custom additions ]]

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- vim: ts=2 sts=2 sw=2 et
