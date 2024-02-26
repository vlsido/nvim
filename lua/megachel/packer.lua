    local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

vim.cmd("packadd packer.nvim")

return require('packer').startup(function(use)
	-- Packer can manage itself
	use ({ 'wbthomason/packer.nvim', opt = true })

  if packer_bootstrap then
    require("packer").sync()
  end

	-- Rose theme
	use({ 'rose-pine/neovim', as = 'rose-pine' })

use 'tjdevries/colorbuddy.nvim'

use 'svrana/neosolarized.nvim'

use {
		-- Telescopik	  
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		requires = { {'nvim-lua/plenary.nvim'} }
}

-- Highlight
use {
  'nvim-treesitter/nvim-treesitter',
  run = function()
    local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
    ts_update()
  end,
}

-- NPM package info
use {
  'vuki656/package-info.nvim',
  requires = 'MunifTanjim/nui.nvim',
}

-- Highlight colors
use {
  'brenoprata10/nvim-highlight-colors',
}


-- Commenting code
use {
  'numToStr/Comment.nvim',
  config = function ()
    require('Comment').setup()
  end
}

use 'lukas-reineke/indent-blankline.nvim'

-- im tired
-- make it pretty baby
use('neovim/nvim-lspconfig')
use('jose-elias-alvarez/null-ls.nvim')
use('MunifTanjim/prettier.nvim')

-- my favret dumb code companion
use {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function ()
    require('copilot').setup({    
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 75,
        keymap = {
          accept = "<Tab>",
          accept_word = false,
          accept_line = false,
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
      },
      filetypes = {
        yaml = false,
        markdown = false,
        help = false,
        gitcommit = false,
        gitrebase = false,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
      copilot_node_command = 'node', -- Node.js version must be > 18.x
      server_opts_overrides = {},
    })
  end,
}

-- use 'github/copilot.vim'

-- nvim tree
use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons',
  }
}
-- git wrapper
use 'tpope/vim-fugitive'

-- language servers
use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  requires = {
    --- Uncomment these if you want to manage LSP servers from neovim
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},

    -- LSP Support
    {'neovim/nvim-lspconfig'},
    -- Autocompletion
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},
  }
}

if packer_bootstrap then
  require("packer").sync()
end

end)






