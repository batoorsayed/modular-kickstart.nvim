-- Adds indentation guides to Neovim.
-- https://github.com/lukas-reineke/indent-blankline.nvim
return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
}

-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
