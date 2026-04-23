-- Cyberpunk colorscheme for Neovim
-- Exact port of thedenisnikulin/vim-cyberpunk + kitty-cyberpunk palette

vim.cmd('highlight clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end
vim.g.colors_name = 'cyberpunk'

local c = {
  bg         = '#120b10',
  bg_dark    = '#140007',
  bg_status  = '#1d000a',
  fg         = '#FF0055',
  black      = '#000000',
  grey       = '#777777',
  red        = '#FF0055',
  red_lt     = '#FF4081',
  red_err    = '#ff3270',
  red_del    = '#ff1745',
  green      = '#009550',
  green_lt   = '#00FF9C',
  green_diff = '#00ff84',
  yellow     = '#F4EF00',
  yellow_lt  = '#FFFC58',
  blue       = '#6766B3',
  blue_lt    = '#76C1FF',
  magenta    = '#D57BFF',
  magenta_lt = '#C592FF',
  cyan       = '#0DCDCD',
  cyan_lt    = '#00FFC8',
  white      = '#EEFFFF',
  white_br   = '#FFFFFF',
  sel        = '#563466',
  colcol     = '#182333',
  search     = '#283593',
  nontext    = '#2B3E5A',
  todo_bg    = '#372963',
  split      = '#101116',
}

local hi = function(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- General
hi('Normal',        { fg = c.fg, bg = c.bg })
hi('Visual',        { bg = c.sel })
hi('ColorColumn',   { bg = c.colcol })
hi('LineNr',        { fg = c.fg })
hi('SignColumn',    { fg = c.cyan_lt })
hi('VertSplit',     { fg = c.fg, bg = c.split })
hi('WinSeparator',  { fg = c.fg, bg = c.split })
hi('NonText',       { fg = c.nontext })
hi('Whitespace',    { fg = c.nontext })
hi('WildMenu',      { fg = c.cyan_lt, bold = true })
hi('Directory',     { fg = c.cyan_lt })
hi('Title',         { fg = c.magenta_lt })

-- Diff
hi('DiffAdd',       {})
hi('DiffDelete',    { bg = c.red_del })
hi('DiffText',      { bg = c.green_diff })
hi('DiffChange',    {})

-- Search
hi('IncSearch',     { bg = c.search })
hi('Search',        { bg = c.search })
hi('Substitute',    { bg = c.search })
hi('MatchParen',    { fg = c.fg, bg = c.cyan_lt })

-- Cursor
hi('Cursor',        { fg = c.cyan_lt })
hi('CursorLineNr',  { fg = c.bg_dark, bg = c.cyan_lt })
hi('CursorLine',    { fg = c.bg_dark, bg = c.fg })
hi('CursorColumn',  {})

-- Syntax
hi('Comment',       { fg = c.blue })
hi('String',        { fg = c.blue_lt })
hi('Number',        { fg = c.yellow_lt })
hi('Float',         { fg = c.yellow_lt })
hi('Boolean',       { fg = c.yellow_lt })
hi('Character',     { fg = c.yellow_lt })
hi('Constant',      { fg = c.yellow_lt })
hi('Conditional',   { fg = c.blue_lt })
hi('Repeat',        { fg = c.blue_lt })
hi('Label',         { fg = c.blue_lt })
hi('Exception',     { fg = c.blue_lt })
hi('Operator',      { fg = c.blue_lt })
hi('Keyword',       { fg = c.blue_lt })
hi('Statement',     { fg = c.blue_lt })
hi('StorageClass',  { fg = c.magenta })
hi('Function',      { fg = c.magenta })
hi('Identifier',    { fg = c.white })
hi('PreProc',       { fg = c.green_lt })
hi('Include',       { fg = c.green_lt })
hi('Define',        { fg = c.green_lt })
hi('Macro',         { fg = c.green_lt })
hi('PreCondit',     { fg = c.green_lt })
hi('Type',          { fg = c.green_lt })
hi('Structure',     { fg = c.green_lt })
hi('Typedef',       { fg = c.green_lt })
hi('Underlined',    {})
hi('Todo',          { fg = c.green_lt, bg = c.todo_bg, italic = true })
hi('Error',         { fg = c.red_err, undercurl = true })
hi('WarningMsg',    { fg = c.green })
hi('Special',       { fg = c.green_lt, italic = true })
hi('SpecialChar',   { fg = c.green_lt, italic = true })
hi('Tag',           { fg = c.green_lt, undercurl = true })
hi('Delimiter',     { fg = c.white })
hi('Debug',         { fg = c.red_err })

-- Popup menu
hi('Pmenu',         { fg = c.fg, bg = c.bg_dark })
hi('PmenuSel',      { fg = c.bg_dark, bg = c.fg })
hi('PmenuSbar',     { bg = c.fg })
hi('PmenuThumb',    {})

-- Status line
hi('StatusLine',    { fg = c.fg, bg = c.bg_status, bold = true })
hi('StatusLineNC',  { fg = c.fg, bg = c.black })

-- Tab line
hi('TabLine',       { fg = c.red_lt })
hi('TabLineFill',   {})
hi('TabLineSel',    { fg = c.red_lt, bold = true })

-- Folds
hi('Folded',        { fg = c.cyan_lt, italic = true })
hi('FoldColumn',    { fg = c.cyan_lt })

-- Float
hi('NormalFloat',   { fg = c.fg, bg = c.bg_dark })
hi('FloatBorder',   { fg = c.fg, bg = c.bg_dark })

-- Messages
hi('ErrorMsg',      { fg = c.red_err })
hi('ModeMsg',       { fg = c.green_lt, bold = true })
hi('MoreMsg',       { fg = c.green_lt })
hi('Question',      { fg = c.cyan_lt })

-- Diagnostics
hi('DiagnosticError', { fg = c.red_err })
hi('DiagnosticWarn',  { fg = c.green })
hi('DiagnosticInfo',  { fg = c.blue_lt })
hi('DiagnosticHint',  { fg = c.cyan_lt })
hi('DiagnosticUnderlineError', { undercurl = true, sp = c.red_err })
hi('DiagnosticUnderlineWarn',  { undercurl = true, sp = c.green })
hi('DiagnosticUnderlineInfo',  { undercurl = true, sp = c.blue_lt })
hi('DiagnosticUnderlineHint',  { undercurl = true, sp = c.cyan_lt })

-- Treesitter (mapped to match the original vim-cyberpunk groups)
hi('@variable',           { fg = c.white })
hi('@variable.builtin',   { fg = c.white })
hi('@variable.parameter', { fg = c.white })
hi('@variable.member',    { fg = c.white })
hi('@constant',           { fg = c.yellow_lt })
hi('@constant.builtin',   { fg = c.yellow_lt })
hi('@string',             { fg = c.blue_lt })
hi('@string.escape',      { fg = c.green_lt, italic = true })
hi('@character',          { fg = c.yellow_lt })
hi('@number',             { fg = c.yellow_lt })
hi('@boolean',            { fg = c.yellow_lt })
hi('@float',              { fg = c.yellow_lt })
hi('@function',           { fg = c.magenta })
hi('@function.builtin',   { fg = c.magenta })
hi('@function.call',      { fg = c.magenta })
hi('@function.macro',     { fg = c.green_lt })
hi('@method',             { fg = c.magenta })
hi('@method.call',        { fg = c.magenta })
hi('@constructor',        { fg = c.green_lt })
hi('@keyword',            { fg = c.blue_lt })
hi('@keyword.function',   { fg = c.blue_lt })
hi('@keyword.operator',   { fg = c.blue_lt })
hi('@keyword.return',     { fg = c.blue_lt })
hi('@keyword.conditional',{ fg = c.blue_lt })
hi('@keyword.repeat',     { fg = c.blue_lt })
hi('@keyword.import',     { fg = c.green_lt })
hi('@keyword.directive',  { fg = c.green_lt })
hi('@operator',           { fg = c.blue_lt })
hi('@type',               { fg = c.green_lt })
hi('@type.builtin',       { fg = c.green_lt })
hi('@type.definition',    { fg = c.green_lt })
hi('@type.qualifier',     { fg = c.blue_lt })
hi('@storage.class',      { fg = c.magenta })
hi('@property',           { fg = c.white })
hi('@attribute',          { fg = c.green_lt })
hi('@tag',                { fg = c.green_lt, undercurl = true })
hi('@tag.attribute',      { fg = c.green_lt })
hi('@tag.delimiter',      { fg = c.white })
hi('@punctuation.bracket',    { fg = c.white })
hi('@punctuation.delimiter',  { fg = c.white })
hi('@punctuation.special',    { fg = c.green_lt })
hi('@comment',            { fg = c.blue })
hi('@comment.todo',       { fg = c.green_lt, bg = c.todo_bg, italic = true })
hi('@comment.note',       { fg = c.blue_lt })
hi('@comment.warning',    { fg = c.green })
hi('@comment.error',      { fg = c.red_err })
hi('@include',            { fg = c.green_lt })
hi('@label',              { fg = c.blue_lt })
hi('@namespace',          { fg = c.green_lt })
