-- Configure linters and formatters
-- see: https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTINS.md

return {
  {
    'nvimtools/none-ls.nvim',
    dependencies = {
      {
        -- Download linters and formatters
        -- Install as required, some lsp's handle this
        -- (lsp's are defined in lsp-config)
        'williamboman/mason.nvim',
      },
    },
    opts = function()
      -- Create vars for readability
      local null_ls = require 'null-ls'
      local formatting = null_ls.builtins.formatting
      local diagnostics = null_ls.builtins.diagnostics
      local code_actions = null_ls.builtins.code_actions

      local sources = {
        -- code actions

        -- diagnostics
        diagnostics.cmake_lint,
        diagnostics.statix,

        -- formatting
        formatting.stylua,
        formatting.prettier,
        formatting.cmake_format,
        formatting.nixpkgs_fmt,
      }
      null_ls.setup { sources = sources }
    end,
  },
}
