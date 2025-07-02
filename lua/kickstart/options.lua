-- [[ Setting Options ]]
-- See `:help vim.o`
-- For more options, see `:help option-list`

-- Make line numbers default, and set relative numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Don't show the mode, it's already in the status line
vim.o.showmode = false

-- Sync clipboard between OS and Neovim. Remove this option if you want OS clipboard to remain independent.
-- Schedule the setting after `UiEnter` because it can increase startup-time.
-- See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching unless \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
-- See `:help 'list'` and `:help 'listchars'`
-- See `:help lua-options` and `:help lua-options-guide` for vim.options vs vim.opt
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type.
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Raise a dialog asking if you wish to save the current file(s) if performing operation that would fail due to unsaved changes.
-- See `:help 'confirm'`
vim.o.confirm = true

-- Set guiding lines at 80 and 120 characters
vim.o.colorcolumn = '80,120'

-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
