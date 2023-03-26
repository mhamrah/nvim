return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
    keys = {
      { '<leader>rn', vim.lsp.buf.rename,                                         '[R]e[n]ame' },
      { '<leader>ca', vim.lsp.buf.code_action,                                    '[C]ode [A]ction' },
      { 'gd',         vim.lsp.buf.definition,                                     '[G]oto [D]efinition' },
      { 'gr',         require('telescope.builtin').lsp_references,                '[G]oto [R]eferences' },
      { 'gI',         vim.lsp.buf.implementation,                                 '[G]oto [I]mplementation' },
      { '<leader>D',  vim.lsp.buf.type_definition,                                'Type [D]efinition' },
      { '<leader>ds', require('telescope.builtin').lsp_document_symbols,          '[D]ocument [S]ymbols' },
      { '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols' },

      -- See `:help K` for why this keymap
      { 'K',          vim.lsp.buf.hover,                                          'Hover Documentation' },
      { '<C-k>',      vim.lsp.buf.signature_help,                                 'Signature Documentation' },

      -- Lesser used LSP functionality
      { 'gD',         vim.lsp.buf.declaration,                                    '[G]oto [D]eclaration' },
      { '<leader>wa', vim.lsp.buf.add_workspace_folder,                           '[W]orkspace [A]dd Folder' },
      { '<leader>wr', vim.lsp.buf.remove_workspace_folder,                        '[W]orkspace [R]emove Folder' },
      { '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders' },

    },
  },
}
