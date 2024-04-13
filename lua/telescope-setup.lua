-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
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

require('which-key').register {}
-- vim: ts=2 sts=2 sw=2 et
