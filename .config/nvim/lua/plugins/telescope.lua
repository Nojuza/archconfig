-- ============================================================================
-- TELESCOPE — Fuzzy finder for everything
-- ============================================================================
-- Telescope lets you search through files, text, buffers, help docs,
-- and pretty much anything else with a fuzzy search popup.
--
-- KEYMAPS:
--   <leader>ff  → Find files by name
--   <leader>fg  → Find text in all files (live grep)
--   <leader>fb  → Find open buffers
--   <leader>fh  → Find help tags
--   <leader>fr  → Find recently opened files
--   <leader>fd  → Find diagnostics (errors/warnings)
--   <leader>f.  → Find files in current directory
--
-- Inside Telescope:
--   <C-j>/<C-k> → Move up/down in results
--   <CR>        → Open selected file
--   <C-x>       → Open in horizontal split
--   <C-v>       → Open in vertical split
--   <Esc>       → Close telescope
-- ============================================================================

return {
  'nvim-telescope/telescope.nvim',

  -- Telescope needs plenary.nvim (a Lua utility library)
  dependencies = {
    'nvim-lua/plenary.nvim',

    -- fzf-native: makes telescope's sorting much faster (compiled C)
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',  -- Compiles the C sorter on install
    },
  },

  config = function()
    local telescope = require('telescope')
    local actions = require('telescope.actions')

    telescope.setup({
      defaults = {
        -- How the search popup looks
        layout_strategy = 'horizontal',
        layout_config = {
          horizontal = { preview_width = 0.5 },
        },
        -- Ignore these directories/files when searching
        file_ignore_patterns = {
          'node_modules',
          '.git/',
          '%.o',       -- Compiled C object files
          '%.out',     -- Compiled binaries
        },
        -- Keymaps inside the telescope popup
        mappings = {
          i = {
            ['<C-j>'] = actions.move_selection_next,
            ['<C-k>'] = actions.move_selection_previous,
            ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
          },
        },
      },
    })

    -- Load the fzf-native extension for faster sorting
    telescope.load_extension('fzf')

    -- -----------------------------------------------------------------------
    -- Keymaps
    -- -----------------------------------------------------------------------
    local builtin = require('telescope.builtin')

    vim.keymap.set('n', '<leader>ff', function()
      builtin.find_files({ cwd = vim.fn.expand('~') })
    end, { desc = 'Find files (from home)' })
    vim.keymap.set('n', '<leader>fg', function()
      builtin.live_grep({ cwd = vim.fn.expand('~') })
    end, { desc = 'Find text (grep from home)' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers,      { desc = 'Find buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags,    { desc = 'Find help' })
    vim.keymap.set('n', '<leader>fr', builtin.oldfiles,     { desc = 'Find recent files' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics,  { desc = 'Find diagnostics' })
    vim.keymap.set('n', '<leader>f.', builtin.find_files,   { desc = 'Find files (cwd)' })
  end,
}
