-- ============================================================================
-- TOGGLETERM — Persistent floating terminal
-- ============================================================================
-- A terminal that you can toggle open/closed without losing your session.
-- It stays in the directory of the file you're editing (via autochdir).
--
-- KEYMAPS:
--   <leader>t   → Toggle the floating terminal
--   <C-\><C-n>  → Exit terminal mode back to normal mode (built-in)
--
-- The terminal session persists — so if you run a command, toggle it
-- closed, then toggle it open again, your command history is still there.
-- ============================================================================

return {
  'akinsho/toggleterm.nvim',
  config = function()
    require('toggleterm').setup({
      -- Open as a floating window
      direction = 'float',
      float_opts = {
        border = 'rounded',
      },
      -- Terminal persists when hidden
      persist_mode = true,
      -- Start in insert mode when opening the terminal
      start_in_insert = true,
    })

    vim.keymap.set({ 'n', 't' }, '<leader>t', '<cmd>ToggleTerm<CR>',
      { desc = 'Toggle terminal' })
  end,
}
