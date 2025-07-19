-- 🍨 Soothing pastel theme for (Neo)vim
-- https://github.com/catppuccin/nvim

-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

return {
  {
    'catppuccin/nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('catppuccin').setup {
        no_italic = true,
        styles = {
          -- italic = false, -- fuck italics, all my homies hate italics
          -- comments = { italic = false }, -- Disable italics in comments
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}

-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
