-- ============================================================================
-- TREESITTER — Smart syntax parsing
-- ============================================================================
-- Treesitter parses your code into a syntax tree instead of using regex.
-- This gives much more accurate syntax highlighting and powers other
-- plugins (flash.nvim, indent-blankline, etc.)
--
-- In nvim 0.12+, treesitter highlighting is built-in and enabled by default.
-- This plugin manages installing/updating the language parsers.
--
-- To install a new language parser:   :TSInstall <language>
-- To see installed parsers:           :TSInstallInfo
-- ============================================================================

return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',  -- Auto-update parsers when plugin updates
  config = function()
    -- Pre-install parsers for languages you use
    local languages = { 'c', 'lua', 'bash', 'python', 'javascript', 'json', 'markdown', 'markdown_inline' }
    for _, lang in ipairs(languages) do
      vim.treesitter.language.add(lang)
    end
  end,
}
