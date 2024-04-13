return {
  'Vigemus/iron.nvim',

  config = function()
    require('iron.core').setup {
      config = {
        -- Highlights the last sent block with bold
        highlight_last = 'IronLastSent',

        -- Toggling behavior is on by default.
        -- Other options are: `single` and `focus`
        visibility = require('iron.visibility').toggle,

        -- Scope of the repl
        -- By default it is one for the same `pwd`
        -- Other options are `tab_based` and `singleton`
        scope = require('iron.scope').path_based,

        -- Whether the repl buffer is a "throwaway" buffer or not
        scratch_repl = false,

        -- Automatically closes the repl window on process end
        close_window_on_exit = true,
        repl_definition = {
          -- forcing a default
          python = require('iron.fts.python').ipython,

          -- new, custom repl
          lua = {
            -- Can be a table or a function that returns a table (see below)
            command = { 'my-lua-repl', '-arg' },
          },
        },

        -- pass a string of vimscript for opening a fixed window:
        repl_open_cmd = 'belowright ' .. vim.o.columns / 2 .. ' vsplit',

        -- If the repl buffer is listed
        buflisted = false,
      },

      -- All the keymaps are set individually
      -- Below is a suggested default
      keymaps = {
        send_motion = '<space>sc',
        visual_send = '<space>sc',
        send_file = '<space>sf',
        send_line = '<space>sl',
        send_until_cursor = '<space>su',
        send_mark = '<space>sm',
        mark_motion = '<space>mc',
        mark_visual = '<space>mc',
        remove_mark = '<space>md',
        cr = '<space>s<cr>',
        interrupt = '<space>s<space>',
        exit = '<space>sq',
        clear = '<space>cl',
      },

      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
    }
  end,
}
