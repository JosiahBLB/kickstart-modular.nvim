-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

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

-- insert mode movement
vim.keymap.set("i", "<C-k>", "<up>", { desc = 'Move up' })
vim.keymap.set("i", "<C-j>", "<down>", { desc = 'Move down' })
vim.keymap.set("i", "<C-h>", "<left>", { desc = 'Move left' })
vim.keymap.set("i", "<C-l>", "<right>", { desc = 'Move right' })
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = 'This is going to get me cancelled --ThePrimeagen 2023' })

-- toggle menus
vim.keymap.set("n", "<leader>u", "<cmd> UndotreeShow <CR>", { desc = 'Toggles undotree window' })
vim.keymap.set("n", "<leader>e", "<cmd> Neotree toggle <CR>", { desc = 'Toggle file tree' })
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = 'Show default vim file tree' })

-- visual mode selection movement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- basic improvements
vim.keymap.set("n", "J", "mzJ`z", { desc = 'Append below to current line with static cursor' })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = 'Screen centred half page jump down' })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = 'Screen centred half page jump up' })
vim.keymap.set("n", "n", "nzzzv", { desc = 'Screen centred jump to previous search term' })
vim.keymap.set("n", "N", "Nzzzv", { desc = 'Screen centred jump to next search term' })

-- preserved deletion and pasting
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = 'Buffer preserved pasting' })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = 'Yank to system clipboard' })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = 'Yank to system clipboard' })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = 'Buffer preserved deletion' })

-- disabled
vim.keymap.set("n", "Q", "<nop>", { desc = 'Disabled' })

-- utilities
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", { desc = '' })
vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { desc = 'Formats document' })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Search and replace' })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = 'Make file executable' })

-- vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = '' })
-- vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = '' })
-- vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = '' })
-- vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = '' })

-- vim: ts=2 sts=2 sw=2 et
