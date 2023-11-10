local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
	-- Packer can manage itself
	use { 'wbthomason/packer.nvim' }

	-- Rose theme
	require('packer').startup(function(use)
		use({ 'rose-pine/neovim', as = 'rose-pine' })
	end)

	use {
		-- Telescopik	  
		'nvim-telescope/telescope.nvim', tag = '0.1.4',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- Highlight
	use {
		'nvim-treesitter/nvim-treesitter',
		run = function()
			local ts_update = require('nvim-treesitter.insta)l').update({ with_sync = true })
			ts_update()
		end,
	}

	-- PG hz
	use 'nvim-treesitter/playground'

    -- Commenting code
    use {
        'numToStr/Comment.nvim',
        config = function ()
            require('Comment').setup()
        end
    }

    -- my favret dumb code companion
    use 'zbirenbaum/copilot.lua'

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

    -- Automatically set up packer
    if packer_bootstrap then
        require('packer').sync()
    end

end)




 

