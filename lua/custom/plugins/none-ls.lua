-- Configure linters and formatters
-- see: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md

return {
  {
    'nvimtools/none-ls.nvim',
    dependancies = {
      {
        -- Download linters and formatters
        -- Install as required, some lsp's handle this
        -- (lsp's are defined in lsp-config)
        'williamboman/mason.nvim',
        ensure_installed = {

          -- lua
          'stylua',

          -- web dev
          'prettier',

          -- -- c/cpp
          -- 'cpplint',
          -- 'clang-format',
          --
          -- -- cmake
          'cmake_lint',
          'cmakelang',
          --
          -- -- python
          -- 'pylint',
          --
          -- -- data
          -- 'jsonlint',
        },
      },
    },
    opts = function()
      -- Create vars for clarity
      local null_ls = require 'null-ls'
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      local code_actions = null_ls.builtins.code_actions

      local sources = {
        -- code actions

        -- diagnostics
        -- diagnostics.jsonlint,
        -- diagnostics.cpplint,
        -- diagnostics.pylint,
        diagnostics.cmake_lint,

        -- formatting
        formatting.stylua,
        formatting.prettier,
        formatting.cmake_format,
      }
      null_ls.setup { sources = sources }
    end,
  },
}
