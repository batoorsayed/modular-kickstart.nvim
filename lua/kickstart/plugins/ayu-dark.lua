-- Ayu dark theme for (Neo)vim
-- https://github.com/Shatur/neovim-ayu

-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.

return {
    {
        'Shatur/neovim-ayu',
        priority = 1000, -- Make sure to load this before all the other start plugins.
        config = function()
            require('ayu').setup {
                mirage = false, -- false = dark, true = mirage (a softer dark)
                overrides = {
                    -- No italics, all my homies hate italics
                    Comment = { italic = false },
                    Keyword = { italic = false },
                    Type = { italic = false },
                },
            }
            vim.cmd.colorscheme 'ayu-dark'
        end,
    },
}

-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
