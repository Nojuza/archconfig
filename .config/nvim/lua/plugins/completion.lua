-- ============================================================================
-- BLINK.CMP — Autocompletion
-- ============================================================================
-- Blink.cmp provides autocomplete suggestions as you type. It pulls from:
--   - LSP (language server — function names, variables, etc.)
--   - Buffer (words already in the current file)
--   - Path (file paths on disk)
--
-- HOW TO USE:
--   Just start typing — suggestions appear automatically.
--
--   <C-n>       → Select next suggestion (or down arrow)
--   <C-p>       → Select previous suggestion (or up arrow)
--   <CR>        → Accept the selected suggestion
--   <C-e>       → Dismiss suggestions
--   <C-space>   → Manually trigger suggestions
--   <Tab>       → Accept or jump to next snippet placeholder
--   <S-Tab>     → Jump to previous snippet placeholder
--
-- The completion menu shows icons indicating the source:
--   ƒ = function, □ = variable, {} = struct, etc.
-- ============================================================================

return {
  'saghen/blink.cmp',
  version = '*',  -- Use latest stable release

  dependencies = {
    -- Snippet engine (for expanding function signatures, etc.)
    { 'rafamadriz/friendly-snippets' },
  },

  config = function()
    require('blink.cmp').setup({

      -- Keymaps for the completion menu
      keymap = {
        preset = 'default',
        -- Enter accepts the selected suggestion, or types a newline if nothing selected
        ['<CR>'] = { 'accept', 'fallback' },
      },

      -- Where completions come from
      sources = {
        default = { 'lsp', 'path', 'buffer', 'snippets' },
      },

      -- How the completion menu looks
      completion = {
        -- Show documentation preview beside the completion menu
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        -- Show a ghost text preview of what will be inserted
        ghost_text = { enabled = true },
      },

      -- Signature help — shows function parameters as you type
      signature = {
        enabled = true,
      },
    })
  end,
}
