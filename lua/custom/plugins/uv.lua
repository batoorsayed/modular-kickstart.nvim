-- uv functionality available in neovim
-- https://github.com/benomahony/uv.nvim

return {
  'benomahony/uv.nvim',
  -- Optional filetype to lazy load when you open a python file
  ft = { 'python' },
  -- Optional dependency, but recommended:
  dependencies = {
    'folke/snacks.nvim' or 'nvim-telescope/telescope.nvim',
  },
  opts = {
    picker_integration = true,
  },
}
-- See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
