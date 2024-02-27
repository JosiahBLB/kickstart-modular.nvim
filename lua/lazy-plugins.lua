-- [[ Configure plugins ]]

require('lazy').setup({
  -- Plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- Undo tree
  'mbbill/undotree',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      {
        'williamboman/mason.nvim',
        config = true,
      },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- For vsnip
      'hrsh7th/cmp-vsnip',
      'hrsh7th/vim-vsnip',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',   opts = {} },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>gsh', gs.stage_hunk, { desc = 'git [s]tage [h]unk' })
        map('n', '<leader>grh', gs.reset_hunk, { desc = 'git [r]eset [h]unk' })
        map('n', '<leader>gsb', gs.stage_buffer, { desc = 'git [s]tage [b]uffer' })
        map('n', '<leader>guh', gs.undo_stage_hunk, { desc = '[u]ndo stage [h]unk' })
        map('n', '<leader>grb', gs.reset_buffer, { desc = 'git [r]eset [b]uffer' })
        map('n', '<leader>gph', gs.preview_hunk, { desc = '[p]review git [h]unk' })
        map('n', '<leader>gb', function()
          gs.blame_line { full = false }
        end, { desc = 'git [b]lame line' })
        map('n', '<leader>gdi', gs.diffthis, { desc = 'git [d]iff against [i]ndex' })
        map('n', '<leader>gdc', function()
          gs.diffthis '~'
        end, { desc = 'git [d]iff against last [c]ommit' })

        -- Toggles
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git [b]lame line' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show [d]eleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git [h]unk' })
      end,
    },
  },

  {
    -- Theme inspired by Atom
    'lunarvim/darkplus.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'darkplus'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'darkplus',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {
      indent = { char = '' },
    },
  },

  {
    -- Allows for commenting out text based on the language
    'numToStr/Comment.nvim',
    opts = {
      mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = false,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = false,
      },
    },
  },

  {
    -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      'MunifTanjim/nui.nvim',
      'nvim-telescope/telescope-ui-select.nvim',
    },
  },

  {
    -- Telescope: File browser
    'nvim-telescope/telescope-file-browser.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim', 'nvim-lua/plenary.nvim' },
  },

  {
    -- Telescope: Launch tabs from fuzzily found firefox bookmarks
    'dhruvmanila/browser-bookmarks.nvim',
    opts = {
      selected_browser = 'firefox',
    },
    dependencies = {
      -- Only if your selected browser is Firefox, Waterfox or buku
      'kkharji/sqlite.lua',

      -- Only if you're using the Telescope extension
      'nvim-telescope/telescope.nvim',
    },
  },

  {
    -- Telescope: Yank history
    'AckslD/nvim-neoclip.lua',
    opts = {},
    dependencies = {
      { 'kkharji/sqlite.lua', module = 'sqlite' },
      'nvim-telescope/telescope.nvim',
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- kickstart goodies
  require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.debug',

  -- [[ Custom plugins ]]
  -- For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- File: lua/custom/plugins/autopairs.lua

  {
    'windwp/nvim-autopairs',
    -- Optional dependency
    dependencies = { 'hrsh7th/nvim-cmp' },
    config = function()
      require('nvim-autopairs').setup {}
      -- If you want to automatically add `(` after selecting a function or method
      local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
      local cmp = require 'cmp'
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
    end,
  },

  { import = 'custom.plugins' },
}, {})

-- vim: ts=2 sts=2 sw=2 et
