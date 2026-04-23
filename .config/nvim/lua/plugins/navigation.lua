-- ============================================================================
-- FILE NAVIGATION — Harpoon, Flash, Oil, Neo-tree
-- ============================================================================
-- Four plugins that each solve a different navigation problem:
--
--   Harpoon  → Bookmark 3-4 files and jump between them instantly
--   Flash    → Jump to any visible text on screen with a few keystrokes
--   Oil      → Edit your filesystem like a normal buffer
--   Neo-tree → Traditional file tree sidebar (like NERDTree)
-- ============================================================================

return {

  -- ==========================================================================
  -- HARPOON — Quick file bookmarks
  -- ==========================================================================
  -- Mark files you're working on, then jump between them with one keystroke.
  -- Much faster than searching when you keep switching between the same files.
  --
  -- KEYMAPS:
  --   <leader>a   → Add current file to harpoon
  --   <leader>hh  → Open harpoon menu (see all bookmarked files)
  --   <leader>1   → Jump to harpoon file 1
  --   <leader>2   → Jump to harpoon file 2
  --   <leader>3   → Jump to harpoon file 3
  --   <leader>4   → Jump to harpoon file 4
  -- ==========================================================================
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',  -- v2 is the Lua rewrite
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require('harpoon')
      harpoon:setup()

      -- Add file to harpoon
      vim.keymap.set('n', '<leader>a', function() harpoon:list():add() end,
        { desc = 'Harpoon: add file' })

      -- Open harpoon menu
      vim.keymap.set('n', '<leader>hh', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = 'Harpoon: open menu' })

      -- Jump to bookmarked files by number
      vim.keymap.set('n', '<leader>1', function() harpoon:list():select(1) end,
        { desc = 'Harpoon: file 1' })
      vim.keymap.set('n', '<leader>2', function() harpoon:list():select(2) end,
        { desc = 'Harpoon: file 2' })
      vim.keymap.set('n', '<leader>3', function() harpoon:list():select(3) end,
        { desc = 'Harpoon: file 3' })
      vim.keymap.set('n', '<leader>4', function() harpoon:list():select(4) end,
        { desc = 'Harpoon: file 4' })
    end,
  },

  -- ==========================================================================
  -- FLASH — Jump anywhere on screen
  -- ==========================================================================
  -- Type 's' then a couple characters — flash labels every match on screen
  -- so you can jump directly to it. Much faster than repeatedly pressing
  -- 'w' or 'f' to move around.
  --
  -- KEYMAPS:
  --   s           → Flash jump (in normal mode)
  --   S           → Flash treesitter (select by syntax node)
  --   r           → Remote flash (in operator-pending mode, e.g. yr = yank remote)
  -- ==========================================================================
  {
    'folke/flash.nvim',
    event = 'VeryLazy',  -- Load when needed, not at startup
    opts = {},            -- Use default settings
    keys = {
      { 's', mode = { 'n', 'x', 'o' },
        function() require('flash').jump() end,
        desc = 'Flash: jump' },
      { 'S', mode = { 'n', 'x', 'o' },
        function() require('flash').treesitter() end,
        desc = 'Flash: treesitter select' },
      { 'r', mode = 'o',
        function() require('flash').remote() end,
        desc = 'Flash: remote' },
    },
  },

  -- ==========================================================================
  -- OIL — Edit filesystem like a buffer
  -- ==========================================================================
  -- Opens a directory as a buffer where you can:
  --   - Rename files by editing the text
  --   - Delete files by deleting lines
  --   - Create files by typing new names
  --   - Move files by cutting/pasting lines
  -- Save the buffer (:w) to apply changes.
  --
  -- KEYMAPS:
  --   <leader>-   → Open parent directory in oil
  --   -           → Go up one directory (inside oil)
  --   <CR>        → Open file/directory
  -- ==========================================================================
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },  -- File icons (needs a Nerd Font)
    config = function()
      require('oil').setup({
        -- Show hidden files (dotfiles)
        view_options = {
          show_hidden = true,
        },
        -- Use floating window instead of taking over the buffer
        float = {
          padding = 4,
          max_width = 100,
          max_height = 30,
        },
      })

      vim.keymap.set('n', '<leader>-', '<cmd>Oil --float<CR>',
        { desc = 'Oil: open file browser' })
    end,
  },

  -- ==========================================================================
  -- NEO-TREE — File tree sidebar
  -- ==========================================================================
  -- A traditional file explorer tree on the left side, like NERDTree or
  -- VS Code's sidebar. Shows git status, lets you create/delete/rename files.
  --
  -- KEYMAPS:
  --   <leader>e   → Toggle the file tree
  --
  -- Inside Neo-tree:
  --   <CR>        → Open file
  --   a           → Add (create) new file/directory
  --   d           → Delete
  --   r           → Rename
  --   y           → Copy file
  --   m           → Move file
  --   ?           → Show all keymaps
  -- ==========================================================================
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',  -- File icons (needs a Nerd Font)
      'MunifTanjim/nui.nvim',         -- UI components library
    },
    config = function()
      require('neo-tree').setup({
        -- Close neo-tree when you open a file
        close_if_last_window = true,
        filesystem = {
          -- Show dotfiles
          filtered_items = {
            visible = true,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
          -- Use the current working directory as root
          follow_current_file = { enabled = true },
        },
        window = {
          width = 30,
        },
      })

      vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>',
        { desc = 'Neo-tree: toggle file tree' })
    end,
  },
}
