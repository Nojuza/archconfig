-- ============================================================================
-- LSP / CODE INTELLIGENCE — Mason, LSPconfig, Trouble, Conform
-- ============================================================================
-- LSP (Language Server Protocol) gives you IDE features:
--   - Autocomplete suggestions
--   - Go to definition / references
--   - Inline error/warning diagnostics
--   - Hover documentation
--   - Code actions (auto-fixes)
--
-- Mason makes installing language servers easy — no manual downloads.
-- Trouble gives you a pretty list of all errors in your project.
-- Conform auto-formats your code on save.
-- ============================================================================

return {

  -- ==========================================================================
  -- MASON — Language server installer
  -- ==========================================================================
  -- Mason installs and manages language servers, formatters, and linters.
  -- Open the Mason UI with :Mason to see what's installed.
  --
  -- Language servers you might want:
  --   clangd    → C/C++
  --   lua_ls    → Lua
  --   pyright   → Python
  --   ts_ls     → JavaScript/TypeScript
  -- ==========================================================================
  {
    'mason-org/mason.nvim',
    config = function()
      require('mason').setup({
        ui = {
          border = 'rounded',
          icons = {
            package_installed = '✓',
            package_pending = '→',
            package_uninstalled = '✗',
          },
        },
      })
    end,
  },

  -- ==========================================================================
  -- MASON-LSPCONFIG — Bridge between Mason and LSPconfig
  -- ==========================================================================
  -- Automatically installs the language servers listed below and
  -- connects them to nvim's LSP client.
  -- ==========================================================================
  {
    'mason-org/mason-lspconfig.nvim',
    dependencies = {
      'mason-org/mason.nvim',
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('mason-lspconfig').setup({
        -- Auto-install these language servers
        ensure_installed = {
          'clangd',     -- C/C++ (you'll use this the most right now)
          'lua_ls',     -- Lua (for editing nvim config)
        },
      })
    end,
  },

  -- ==========================================================================
  -- NVIM-LSPCONFIG — Configure language servers
  -- ==========================================================================
  -- This sets up the actual language server connections and keymaps.
  -- Once configured, you get real-time errors, autocomplete, and more.
  --
  -- KEYMAPS (only work when a language server is active):
  --   gd          → Go to definition (where a function is defined)
  --   gr          → Go to references (where a function is used)
  --   K           → Hover docs (show info about thing under cursor)
  --   <leader>ca  → Code action (auto-fix suggestions)
  --   <leader>rn  → Rename symbol (renames everywhere it's used)
  --   [d          → Go to previous diagnostic (error/warning)
  --   ]d          → Go to next diagnostic
  -- ==========================================================================
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'mason-org/mason-lspconfig.nvim' },
    config = function()
      -- -------------------------------------------------------------------
      -- LSP Keymaps — set up when a language server attaches to a file
      -- -------------------------------------------------------------------
      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          -- Helper to make keymap definitions shorter
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Navigation
          map('gd', vim.lsp.buf.definition, 'Go to definition')
          map('gr', vim.lsp.buf.references, 'Go to references')
          map('gD', vim.lsp.buf.declaration, 'Go to declaration')
          map('gi', vim.lsp.buf.implementation, 'Go to implementation')

          -- Information
          map('K', vim.lsp.buf.hover, 'Hover documentation')
          map('<leader>D', vim.lsp.buf.type_definition, 'Type definition')

          -- Actions
          map('<leader>ca', vim.lsp.buf.code_action, 'Code action')
          map('<leader>rn', vim.lsp.buf.rename, 'Rename symbol')

          -- Diagnostics
          map('[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
          map(']d', vim.diagnostic.goto_next, 'Next diagnostic')
          map('<leader>d', vim.diagnostic.open_float, 'Show diagnostic message')
        end,
      })

      -- -------------------------------------------------------------------
      -- Configure individual language servers (nvim 0.12+ API)
      -- -------------------------------------------------------------------
      -- vim.lsp.config defines settings, vim.lsp.enable activates them.

      -- C/C++ — uses clangd
      vim.lsp.config('clangd', {})
      vim.lsp.enable('clangd')

      -- Lua — configured for Neovim development
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            -- Tell lua_ls about the 'vim' global so it doesn't warn
            diagnostics = { globals = { 'vim' } },
            workspace = { checkThirdParty = false },
          },
        },
      })
      vim.lsp.enable('lua_ls')
    end,
  },

  -- ==========================================================================
  -- TROUBLE — Pretty diagnostics list
  -- ==========================================================================
  -- Shows all errors, warnings, and TODOs in a nice organized panel.
  --
  -- KEYMAPS:
  --   <leader>xx  → Toggle trouble panel
  --   <leader>xw  → Workspace diagnostics (all files)
  --   <leader>xd  → Document diagnostics (current file only)
  -- ==========================================================================
  {
    'folke/trouble.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('trouble').setup({})

      vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>',
        { desc = 'Trouble: toggle' })
      vim.keymap.set('n', '<leader>xw', '<cmd>Trouble diagnostics toggle<CR>',
        { desc = 'Trouble: workspace diagnostics' })
      vim.keymap.set('n', '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>',
        { desc = 'Trouble: document diagnostics' })
    end,
  },

  -- ==========================================================================
  -- CONFORM — Auto-format code on save
  -- ==========================================================================
  -- Automatically formats your code when you save the file.
  -- Uses clang-format for C, stylua for Lua, etc.
  --
  -- You can also format manually with <leader>cf.
  -- To install formatters, use Mason (:Mason) or your system package manager.
  -- ==========================================================================
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',  -- Load right before saving
    config = function()
      require('conform').setup({
        -- Which formatter to use for each language
        formatters_by_ft = {
          c = { 'clang-format' },
          lua = { 'stylua' },
          python = { 'black' },
          javascript = { 'prettier' },
        },
        -- Format on save (runs automatically when you :w)
        -- Returns nil if no formatter is available, so saves still work
        format_on_save = function(bufnr)
          local formatters = require('conform').list_formatters(bufnr)
          if #formatters == 0 then return end
          return { timeout_ms = 500, lsp_format = 'fallback' }
        end,
      })

      vim.keymap.set('n', '<leader>cf', function()
        require('conform').format({ async = true, lsp_format = 'fallback' })
      end, { desc = 'Format file' })
    end,
  },
}
