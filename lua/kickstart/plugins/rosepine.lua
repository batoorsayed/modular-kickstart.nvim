-- Soho vibes for Neovim
-- https://github.com/rose-pine/neovim


-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

return {
  {
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'rose-pine/neovim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('rose-pine').setup {
        styles = {
          italic = false, -- fuck italics, all my homies hate italics
          -- comments = { italic = false }, -- Disable italics in comments
        },
      }
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
}

-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
