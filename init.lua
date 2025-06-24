-- NOTE: Thanks to Kickstart.nvim for all of the actual hard work!
-- https://github.com/nvim-lua/kickstart.nvim


-- Set <space> as the leader key. See `:help mapleader`
-- Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting Options]]
require 'kickstart.options'

-- [[ Basic Keymaps ]]
require 'kickstart.keymaps'

-- [[ Basic Autocommands ]]
require 'kickstart.autocommands'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'kickstart.lazy-handler'

-- [[ Configure and install plugins ]]
-- To check the current status of your plugins, run :Lazy. To update plugins you can run :Lazy update
require('lazy').setup({
  require 'kickstart.plugins.guessindent',     -- Automatically detects the indent style of the file you are editing
  require 'kickstart.plugins.gitsigns',        -- Git integration for buffers
  require 'kickstart.plugins.which-key',       -- Shows you pending keybinds
  require 'kickstart.plugins.telescope',       -- Fuzzy finder for files, buffers, etc.
  require 'kickstart.plugins.lspconfig',       -- Language Server Protocol (LSP) configuration
  require 'kickstart.plugins.autoformat',      -- Automatically formats code on save
  require 'kickstart.plugins.autocompletion',  -- Autocompletion for code
  require 'kickstart.plugins.rosepine',        -- Soho vibes for Neovim
  require 'kickstart.plugins.todo-comments',   -- Highlight TODO comments in code
  require 'kickstart.plugins.mini-nvim',       -- Collection of various small independent plugins/modules
  require 'kickstart.plugins.nvim-treesitter', -- Highlight, edit, and navigate code
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  -- { import = 'custom.plugins' },

}, {
  ui = {
    icons = {}, -- Not needed if you have a Nerd Font installed
  },
})

-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
