-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>od', vim.diagnostic.open_float, { desc = '[o]pen floating [d]iagnostic message' })
vim.keymap.set('n', '<leader>odl', vim.diagnostic.setloclist, { desc = '[o]pen [d]iagnostics [l]ist' })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Custom bindings ]]

-- basic b*tch bindings
vim.keymap.set({ 'n', 'v', 'i' }, '<C-s>', '<cmd>w<CR>', { desc = 'Save file' })
-- pasting
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste and replace selection' })
vim.keymap.set('n', '<leader>p', [[""p]], { desc = 'Paste from vim clipboard' })
vim.keymap.set('n', '<leader>P', [[""P]], { desc = 'Paste from vim clipboard' })
vim.keymap.set('n', 'p', [["+p]], { desc = 'Paste from system clipboard' })
vim.keymap.set('n', 'P', [["+P]], { desc = 'Paste from system clipboard' })
-- copying
vim.keymap.set({ 'n', 'v' }, '<C-c>', [["+y]], { desc = 'Yank to system clipboard' })
vim.keymap.set({ 'n', 'v' }, 'y', [["+y]], { desc = 'Yank to system clipboard' })
vim.keymap.set('n', 'Y', [["+Y]], { desc = 'Yank to system clipboard' })
vim.keymap.set('n', '<leader>Y', [[""Y]], { desc = 'Yank to vim clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>y', [[""y]], { desc = 'Yank to vim clipboard' })

-- insert mode movement
vim.keymap.set('i', '<C-k>', '<up>', { desc = 'Move up' })
vim.keymap.set('i', '<C-j>', '<down>', { desc = 'Move down' })
vim.keymap.set('i', '<C-h>', '<left>', { desc = 'Move left' })
vim.keymap.set('i', '<C-l>', '<right>', { desc = 'Move right' })

-- toggle menus
vim.keymap.set('n', '<leader>u', '<cmd>UndotreeToggle<CR>', { desc = 'Toggle undotree window' })
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = 'Show default vim file tree' })

-- visual mode selection movement
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- basic improvements
vim.keymap.set('n', '<leader>a', '<C-6>', { desc = 'Previous buffer' })
vim.keymap.set('n', '<leader>q', '<cmd>bd<cr>', { desc = 'Close current buffer' })
vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Append below to current line with static cursor' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Screen centred half page jump down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Screen centred half page jump up' })
vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Screen centred jump to previous search term' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Screen centred jump to next search term' })

-- Comment.nvim (taken from nvchad)
vim.keymap.set('n', '<leader>/', function()
  require('Comment.api').toggle.linewise.current()
end, { desc = 'Toggle Comment' })
vim.keymap.set('v', '<leader>/', '<ESC><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>',
  { desc = 'Toggle Comment' })

-- disabled
vim.keymap.set('n', 'Q', '<nop>', { desc = 'Disabled' })

-- utilities
vim.keymap.set('n', '<leader>fm', vim.lsp.buf.format, { desc = '[f]or[m]at document' })
vim.keymap.set('n', '<leader>mx', '<cmd>!chmod +x %<CR>', { silent = true, desc = '[m]ake file e[x]ecutable' })

-- [[ Plugins ]]

-- Oil
vim.keymap.set('n', '<leader>E', '<cmd>Oil --float .<CR>', { desc = 'Open file explorer in oil' })


vim.keymap.set('n', '<leader>rf', function()
  require('runner').run_file()
end, { desc = '[r]un [f]ile' })

-- vim: ts=2 sts=2 sw=2 et
