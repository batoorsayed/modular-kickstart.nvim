-- WhichKey helps you remember your Neovim keymaps, by showing available keybindings in a popup as you type.
-- https://github.com/folke/which-key.nvim


-- Plugins can also be configured to run Lua code when they are loaded.
-- In the following configuration, we use: event = 'VimEnter' which loads which-key before all the UI elements are loaded.
-- Then, because we use the `opts` key, the configuration runs after the plugin has been loaded as `require(MODULE).setup(opts)`.

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      -- this setting is independent of vim.o.timeoutlen
      delay = 0,
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = true,
        -- Use default which-key.nvim defined Nerd font
        keys = {},
      },
      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },
}

-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et