-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
local builtin = require 'telescope.builtin'
local telescope = require 'telescope'

pcall(telescope.load_extension, 'fzf')
pcall(telescope.load_extension, 'file_browser')
pcall(telescope.load_extension, 'neoclip')
pcall(telescope.load_extension, 'browser_bookmarks')

telescope.setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
    },
    color_devicons = true,
    prompt_prefix = ' 󰍉 ',
    scroll_strategy = 'cycle',
    sorting_strategy = 'ascending',
    winblend = 10,
    layout_strategy = 'flex',
    layout_config = {
      prompt_position = 'top',
      horizontal = {
        mirror = false,
        preview_cutoff = 100,
        preview_width = 0.5,
      },
      vertical = {
        mirror = true,
        preview_cutoff = 0.4,
      },
      flex = {
        flip_columns = 128,
      },
      height = 0.94,
      width = 0.86,
    },
  },
  pickers = {
    find_file = { hidden = true },
  },
}

require('neoclip').setup { -- yank history
  enable_persistent_history = true,
}

require('cheatsheet').setup { -- cheatsheet
}

---@diagnostic disable-next-line: missing-fields
require('browser_bookmarks').setup {
  -- override default configuration values
  selected_browser = 'firefox',
  -- see url in firefox about:support
  config_dir = '/Users/josiah/Library/Application Support/Firefox/Profiles/lxlc86f3.default-release-1',
}

-- [[ disabled ]]
-- local harpoon = require 'harpoon'
-- harpoon:setup {}
--
-- -- basic telescope configuration
-- local conf = require('telescope.config').values
-- vim.api.nvim_create_user_command('HarpoonToggle', function()
--   local file_paths = {}
--   for _, item in ipairs(harpoon:list().items) do
--     table.insert(file_paths, item.value)
--   end
--
--   require('telescope.pickers')
--   .new({}, {
--     prompt_title = 'Harpoon',
--     finder = require('telescope.finders').new_table {
--       results = file_paths,
--     },
--     previewer = conf.file_previewer {},
--     sorter = conf.generic_sorter {},
--   })
--   :find()
-- end, {})
--
-- -- Telescope live_grep in git root
-- -- Function to find the git root directory based on the current buffer's path
-- local function find_git_root()
--   -- Use the current buffer's path as the starting point for the git search
--   local current_file = vim.api.nvim_buf_get_name(0)
--   local current_dir
--   local cwd = vim.fn.getcwd()
--   -- If the buffer is not associated with a file, return nil
--   if current_file == '' then
--     current_dir = cwd
--   else
--     -- Extract the directory from the current file's path
--     current_dir = vim.fn.fnamemodify(current_file, ':h')
--   end
--
--   -- Find the Git root directory from the current file's path
--   local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
--   if vim.v.shell_error ~= 0 then
--     print 'Not a git repository. Searching on current working directory'
--     return cwd
--   end
--   return git_root
-- end
--
-- Custom live_grep function to search in git root
-- local function live_grep_git_root()
--   local git_root = find_git_root()
--   if git_root then
--     require('telescope.builtin').live_grep {
--       search_dirs = { git_root },
--     }
--   end
-- end
--
-- vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- local function telescope_live_grep_open_files()
--   require('telescope.builtin').live_grep {
--     grep_open_files = true,
--     prompt_title = 'Live Grep in Open Files',
--   }
-- end

-- vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[s]earch by [G]rep on git root' })
-- vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[s]earch current [w]ord' })
-- vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[s]earch [r]esume' })
-- vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[s]earch [/] in open files' })
-- vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin, { desc = '[s]earch [s]elect telescope' })
-- vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = '[g]it search [f]iles' })

require('which-key').register {}
-- vim: ts=2 sts=2 sw=2 et
