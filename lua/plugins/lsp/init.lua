return {
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      { 'folke/neoconf.nvim', cmd = 'Neoconf', config = true },
      {
        'folke/neodev.nvim',
        opts = {
          library = { plugins = { 'neotest', 'nvim-dap-ui' }, types = true },
        },
      },
      { 'j-hui/fidget.nvim', config = true },
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'jay-babu/mason-null-ls.nvim',
    },
    opts = {
      servers = {
        terraformls = {},
        pyright = {},
        eslint = {},
        cssls = {},
        bufls = {},
        svelte = {},
        zls = {},
        astro = {},
        gopls = {},
        rust_analyzer = {},
        tsserver = {},
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      },
    },
    keys = {
      { '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame' },
      { '<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction' },
      { 'gd', vim.lsp.buf.definition, '[G]oto [D]efinition' },
      { 'gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences' },
      { 'gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation' },
      { '<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition' },
      { '<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols' },
      { '<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols' },
      { '<leader>cf', require('plugins.lsp.format').format, {
        desc = 'Format Document',
        has = 'documentFormatting',
      } },
      {
        '<leader>cf',
        require('plugins.lsp.format').format,
        {
          desc = 'Format Range',
          mode = 'v',
          has = 'documentRangeFormatting',
        },
      },

      -- See `:help K` for why this keymap
      { 'K', vim.lsp.buf.hover, 'Hover Documentation' },
      { '<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation' },

      -- Lesser used LSP functionality
      { 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration' },
      { '<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder' },
      { '<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder' },
      {
        '<leader>wl',
        function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
        '[W]orkspace [L]ist Folders',
      },
    },
    config = function()
      -- Switch for controlling whether you want autoformatting.
      --  Use :KickstartFormatToggle to toggle autoformatting on or off
      local format_is_enabled = true
      vim.api.nvim_create_user_command('KickstartFormatToggle', function()
        format_is_enabled = not format_is_enabled
        print('Setting autoformatting to: ' .. tostring(format_is_enabled))
      end, {})

      -- Create an augroup that is used for managing our formatting autocmds.
      --      We need one augroup per client to make sure that multiple clients
      --      can attach to the same buffer without interfering with each other.
      local _augroups = {}
      local get_augroup = function(client)
        if not _augroups[client.id] then
          local group_name = 'kickstart-lsp-format-' .. client.name
          local id = vim.api.nvim_create_augroup(group_name, { clear = true })
          _augroups[client.id] = id
        end

        return _augroups[client.id]
      end

      -- Whenever an LSP attaches to a buffer, we will run this function.
      --
      -- See `:help LspAttach` for more information about this autocmd event.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach-format', { clear = true }),
        -- This is where we attach the autoformatting for reasonable clients
        callback = function(args)
          local client_id = args.data.client_id
          local client = vim.lsp.get_client_by_id(client_id)
          local bufnr = args.buf

          -- Only attach to clients that support document formatting
          if not client.server_capabilities.documentFormattingProvider then
            return
          end

          -- Create an autocmd that will run *before* we save the buffer.
          --  Run the formatting command for the LSP that has just attached.
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = get_augroup(client),
            buffer = bufnr,
            callback = function()
              if not format_is_enabled then
                return
              end

              vim.lsp.buf.format {
                async = false,
                filter = function(c)
                  return c.id == client.id
                end,
              }
            end,
          })
        end,
      })
    end,
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPre',
    dependencies = { 'mason.nvim' },
    config = function()
      local nls = require 'null-ls'
      nls.setup {
        sources = {
          nls.builtins.formatting.stylua,
          nls.builtins.formatting.black,
          nls.builtins.formatting.shfmt,
          nls.builtins.diagnostics.ruff.with { extra_args = { '--max-line-length=180' } },
        },
      }
    end,
  },
}
