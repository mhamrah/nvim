local M = {
  'mfussenegger/nvim-dap',
  dependencies = {
    { 'rcarriga/nvim-dap-ui' },
    { 'theHamsta/nvim-dap-virtual-text' },
    { 'nvim-telescope/telescope-dap.nvim' },
    { 'jbyuki/one-small-step-for-vimkind' },
    { 'williamboman/mason.nvim' },
    { 'jay-babu/mason-nvim-dap.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope.nvim' },
    -- Add your own debuggers here
    { 'leoluz/nvim-dap-go' },
    { 'mxsdev/nvim-dap-vscode-js', module = { 'dap-vscode-js' } },
    {
      'microsoft/vscode-js-debug',
      opt = true,
      run = 'npm install --legacy-peer-deps && npm run compile',
      disable = false,
    },
  },
  -- stylua: ignore
  keys = {
    { "<leader>dR", function() require("dap").run_to_cursor() end,                        desc = "Run to Cursor", },
    { "<leader>dE", function() require("dapui").eval(vim.fn.input "[Expression] > ") end, desc = "Evaluate Input", },
    {
      "<leader>dC",
      function() require("dap").set_breakpoint(vim.fn.input "[Condition] > ") end,
      desc =
      "Conditional Breakpoint",
    },
    { "<leader>dU", function() require("dapui").toggle() end,   desc = "Toggle UI", },
    { "<leader>db", function() require("dap").step_back() end,  desc = "Step Back", },
    { "<leader>dc", function() require("dap").continue() end,   desc = "Continue", },
    { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect", },
    {
      "<leader>de",
      function() require("dapui").eval() end,
      mode = { "n", "v" },
      desc =
      "Evaluate",
    },
    { "<leader>dg", function() require("dap").session() end,           desc = "Get Session", },
    { "<leader>dh", function() require("dap.ui.widgets").hover() end,  desc = "Hover Variables", },
    { "<leader>dS", function() require("dap.ui.widgets").scopes() end, desc = "Scopes", },
    { "<leader>di", function() require("dap").step_into() end,         desc = "Step Into", },
    { "<leader>do", function() require("dap").step_over() end,         desc = "Step Over", },
    { "<leader>dp", function() require("dap").pause.toggle() end,      desc = "Pause", },
    { "<leader>dq", function() require("dap").close() end,             desc = "Quit", },
    { "<leader>dr", function() require("dap").repl.toggle() end,       desc = "Toggle REPL", },
    { "<leader>ds", function() require("dap").continue() end,          desc = "Start", },
    {
      "<leader>dt",
      function() require("dap").toggle_breakpoint() end,
      desc =
      "Toggle Breakpoint",
    },
    { "<leader>dx", function() require("dap").terminate() end, desc = "Terminate", },
    { "<leader>du", function() require("dap").step_out() end,  desc = "Step Out", },
  },
  opts = {
    setup = {
      osv = function(_, _)
        require('plugins.dap.lua').setup()
      end,
    },
  },
  config = function(plugin, opts)
    require('nvim-dap-virtual-text').setup {
      commented = true,
    }

    local dap, dapui = require 'dap', require 'dapui'
    dapui.setup {}

    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
    require('mason-nvim-dap').setup {
      -- makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,

      -- you'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- update this to ensure that you have the debuggers for the langs you want
        'delve',
        'chrome',
        'node2',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          play = '',
          step_into = '',
          step_over = '',
          step_out = '',
          step_back = '',
          run_last = '',
          terminate = '',
        },
      },
    }

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup()
    require('plugins.dap.lua').setup()
    require('plugins.dap.javascript').setup()
    require('plugins.dap.typescript').setup()
    -- You can provide additional configuration to the handlers,
    -- see mason-nvim-dap README for more information
    require('mason-nvim-dap').setup_handlers()

    -- set up debugger
    for k, _ in pairs(opts.setup) do
      opts.setup[k](plugin, opts)
    end
  end,
}

return M
