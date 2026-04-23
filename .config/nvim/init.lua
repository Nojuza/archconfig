-- ============================================================================
--                          NEOVIM CONFIGURATION
-- ============================================================================
-- Structure:
--   init.lua          → Core settings, leader key, lazy.nvim bootstrap
--   lua/plugins/*.lua → Plugin configs (auto-imported by lazy.nvim)
--   colors/*.lua      → Colorschemes
-- ============================================================================


-- ============================================================================
-- LEADER KEY (must be set before plugins load)
-- ============================================================================
-- Space as leader key — used as a prefix for custom shortcuts
-- e.g. <leader>ff means: Space, then f, then f
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '


-- ============================================================================
-- CORE OPTIONS
-- ============================================================================

-- Line numbers: shows both absolute (current line) and relative (distance)
vim.opt.number = true
vim.opt.relativenumber = true

-- Clipboard — yank/paste uses system clipboard (wl-copy on Wayland)
vim.opt.clipboard = 'unnamedplus'

-- Tabs/indentation — 2 spaces, no real tab characters
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftround = false

-- Text formatting
vim.opt.wrap = false               -- Don't wrap long lines
vim.opt.textwidth = 79             -- Auto-break lines at 79 chars
vim.opt.formatoptions = 'tcqrn1'
vim.opt.formatoptions:remove('ro') -- Don't auto-insert comment leaders

-- Search
vim.opt.hlsearch = true   -- Highlight all search matches
vim.opt.incsearch = true  -- Highlight as you type
vim.opt.ignorecase = true -- Case-insensitive search...
vim.opt.smartcase = true  -- ...unless you type a capital letter
vim.opt.showmatch = true  -- Briefly highlight matching bracket

-- Cursor and scrolling
vim.opt.scrolloff = 8      -- Keep 8 lines visible above/below cursor
--vim.opt.cursorline = true  -- Highlight the line the cursor is on
vim.opt.signcolumn = 'yes' -- Always show the sign column (prevents jitter)

-- Splits — open new splits below and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Misc
vim.opt.termguicolors = true -- True color support (for colorscheme hex colors)
vim.opt.updatetime = 250     -- Faster updates (default 4000ms) for plugins
vim.opt.undofile = true      -- Persistent undo — survives closing the file
vim.opt.mouse = 'a'          -- Enable mouse in all modes
vim.opt.autochdir = true     -- Auto cd to the directory of the current file


-- ============================================================================
-- BASIC KEYMAPS (non-plugin)
-- ============================================================================

-- Clear search highlighting with <leader><space>
vim.keymap.set('n', '<leader><space>', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

-- Move between splits with Ctrl + hjkl
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left split' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to lower split' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to upper split' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right split' })

-- Move lines up/down in visual mode
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })


-- ============================================================================
-- BOOTSTRAP LAZY.NVIM (plugin manager)
-- ============================================================================
-- Lazy.nvim auto-installs itself on first run, then loads all plugin
-- configs from the lua/plugins/ directory.
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load all plugin specs from lua/plugins/*.lua
require('lazy').setup({
  { import = 'plugins' },
}, {
  -- Show a nice UI when installing/updating plugins
  ui = { border = 'rounded' },
  -- Check for plugin updates automatically
  checker = { enabled = true, notify = false },
})


-- ============================================================================
-- COLORSCHEME
-- ============================================================================
-- Uses the Cyberpunk theme (matched to kitty terminal colors)
-- Defined in: ~/.config/nvim/colors/cyberpunk.lua
vim.cmd('colorscheme cyberpunk')
