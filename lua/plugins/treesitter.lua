return {
  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    version = false, -- last release is way too old and doesn't work on Windows
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { {
      'nvim-treesitter/nvim-treesitter-textobjects',
      init = function()
        -- PERF: no need to load the plugin, if we only need its queries for mini.ai
        local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
        local opts = require("lazy.core.plugin").values(plugin, "opts", false)
        local enabled = false
        if opts.textobjects then
          for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
            if opts.textobjects[mod] and opts.textobjects[mod].enable then
              enabled = true
              break
            end
          end
        end
        if not enabled then
          require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
        end
      end,
    }, "windwp/nvim-ts-autotag" },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "cue",
        "go",
        "graphql",
        "hcl",
        "help",
        "help",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown_inline",
        "proto",
        "python",
        "query",
        "regex",
        "rust",
        "sql",
        "svelte",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
        "zig",
        "astro",
      },
      autotag = {
        enable = true,
      },
      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true, disable = { 'python' } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<c-space>',
          node_incremental = '<c-space>',
          scope_incremental = '<c-s>',
          node_decremental = '<M-space>',
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    }
  },

}
