-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

return require('lazy').setup({
  -- for vim telescope
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },

  -- colorscheme
  { 'catppuccin/nvim', as = 'catppuccin' },
  { 'rebelot/kanagawa.nvim', as = 'kanagawa' },

  -- transparent background
  { 'tribela/transparent.nvim' },

  -- treesitter for color hinting
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },
  { 'nvim-treesitter/playground' },

  -- harpoon for navigation
  { 'theprimeagen/harpoon' },

  -- for undo exploration
  { 'mbbill/undotree' },

  -- for git actions
  { 'tpope/vim-fugitive' },

  -- lsp pluggins from lsp-zero
  { 'neovim/nvim-lspconfig' },
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'VonHeikemen/lsp-zero.nvim' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },

  -- for closing braces
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup {}
      end
  },

  -- flutter dev tools
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim", -- optional for vim.ui.select
    },
    config = true,
    debugger = {
      enabled = true,
      register_configurations = function(_)
        -- require("dap").configurations.dart = {}
        -- require("dap.ext.vscode").load_launchjs()
      end,
    },
  },
})
