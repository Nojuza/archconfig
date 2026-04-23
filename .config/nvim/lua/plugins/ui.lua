-- ============================================================================
-- UI ENHANCEMENTS — Lualine, Noice, Which-key, Indent guides, Todo
-- ============================================================================
-- Plugins that make Neovim look and feel more like a modern editor.
-- ============================================================================

return {

  -- ==========================================================================
  -- LUALINE — Statusline
  -- ==========================================================================
  -- Replaces the default status bar at the bottom with a much nicer one.
  -- Shows: mode, branch, filename, diagnostics, file type, cursor position.
  -- ==========================================================================
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = {
          -- Use your cyberpunk colors
          theme = {
            normal = {
              a = { fg = '#120b10', bg = '#FF0055', gui = 'bold' },
              b = { fg = '#FF0055', bg = '#1d000a' },
              c = { fg = '#EEFFFF', bg = '#120b10' },
            },
            insert = {
              a = { fg = '#120b10', bg = '#00FFC8', gui = 'bold' },
            },
            visual = {
              a = { fg = '#120b10', bg = '#D57BFF', gui = 'bold' },
            },
            replace = {
              a = { fg = '#120b10', bg = '#FFFC58', gui = 'bold' },
            },
            command = {
              a = { fg = '#120b10', bg = '#76C1FF', gui = 'bold' },
            },
            inactive = {
              a = { fg = '#FF0055', bg = '#000000' },
              b = { fg = '#FF0055', bg = '#000000' },
              c = { fg = '#777777', bg = '#120b10' },
            },
          },
          -- Use rounded separators between sections
          section_separators = { left = '', right = '' },
          component_separators = { left = '│', right = '│' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { 'encoding', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
      })
    end,
  },

  -- ==========================================================================
  -- NOICE — Modern UI for messages, cmdline, and popups
  -- ==========================================================================
  -- Replaces the boring bottom command line with floating windows.
  -- Messages, search, and the command line all get a modern look.
  --
  -- :Noice      → Show message history
  -- :Noice last → Show the last message
  -- ==========================================================================
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',       -- UI components
      'rcarriga/nvim-notify',       -- Notification popups
    },
    config = function()
      require('noice').setup({
        -- Use a popup for the command line instead of the bottom bar
        cmdline = {
          view = 'cmdline_popup',
        },
        -- Use mini view for certain messages to reduce noise
        routes = {
          -- Hide "written" messages when saving
          {
            filter = { event = 'msg_show', kind = '', find = 'written' },
            opts = { skip = true },
          },
        },
        -- Replace some default UI elements
        presets = {
          bottom_search = false,         -- Use a popup for search too
          command_palette = true,         -- Command line looks like a palette
          long_message_to_split = true,   -- Long messages open in a split
          lsp_doc_border = true,          -- Add borders to hover docs
        },
      })

      -- Configure nvim-notify to match the cyberpunk theme
      require('notify').setup({
        background_colour = '#120b10',
        timeout = 3000,
        stages = 'fade',
      })
    end,
  },

  -- ==========================================================================
  -- WHICH-KEY — Keybinding helper
  -- ==========================================================================
  -- When you press <leader> (space) and wait, a popup appears showing
  -- all available keybindings. Great for learning your shortcuts.
  --
  -- It also groups related keymaps together:
  --   <leader>f → "Find" group (telescope)
  --   <leader>h → "Harpoon" group
  --   <leader>x → "Trouble" group
  --   etc.
  -- ==========================================================================
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      local wk = require('which-key')

      wk.setup({
        -- Use a rounded border for the popup
        win = { border = 'rounded' },
      })

      -- Register group labels so the popup shows nice names
      wk.add({
        { '<leader>f', group = 'Find (Telescope)' },
        { '<leader>h', group = 'Harpoon' },
        { '<leader>x', group = 'Trouble (Diagnostics)' },
        { '<leader>c', group = 'Code' },
      })
    end,
  },

  -- ==========================================================================
  -- INDENT-BLANKLINE — Indent guide lines
  -- ==========================================================================
  -- Shows thin vertical lines at each indentation level, making it much
  -- easier to see code structure (especially in deeply nested code).
  -- ==========================================================================
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',  -- The module name is 'ibl', not 'indent-blankline'
    config = function()
      require('ibl').setup({
        indent = {
          char = '│',              -- The character used for indent lines
          tab_char = '│',
        },
        scope = {
          enabled = true,           -- Highlight the current scope
          show_start = false,       -- Don't underline scope start
          show_end = false,         -- Don't underline scope end
        },
      })
    end,
  },

  -- ==========================================================================
  -- TODO-COMMENTS — Highlight TODO/FIXME/HACK/NOTE comments
  -- ==========================================================================
  -- Makes special comments stand out with colors and icons:
  --   TODO:    → Blue
  --   FIXME:   → Red
  --   HACK:    → Orange
  --   NOTE:    → Green
  --   WARNING: → Yellow
  --
  -- KEYMAPS:
  --   <leader>ft  → Find all TODOs in the project (via Telescope)
  --   ]t          → Jump to next TODO comment
  --   [t          → Jump to previous TODO comment
  -- ==========================================================================
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('todo-comments').setup({})

      vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<CR>',
        { desc = 'Find TODOs' })
      vim.keymap.set('n', ']t', function()
        require('todo-comments').jump_next()
      end, { desc = 'Next TODO comment' })
      vim.keymap.set('n', '[t', function()
        require('todo-comments').jump_prev()
      end, { desc = 'Previous TODO comment' })
    end,
  },

  -- ==========================================================================
  -- NVIM-WEB-DEVICONS — File type icons
  -- ==========================================================================
  -- Provides icons for file types used by many other plugins
  -- (neo-tree, lualine, telescope, etc.)
  --
  -- NOTE: You need a Nerd Font installed for icons to display correctly.
  -- If you see broken squares instead of icons, install a Nerd Font:
  --   https://www.nerdfonts.com/
  -- Then set it as your terminal font in kitty.conf:
  --   font_family YourNerdFont
  -- ==========================================================================
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup({
        -- Use default icons
        default = true,
      })
    end,
  },
}
