local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
  -- Packer can manage itself
  local is_windows = vim.loop.os_uname().version:match("Windows")

  if is_windows then
    use({ "wbthomason/packer.nvim", opt = true })
  else
    use({ "wbthomason/packer.nvim" })
  end

  -- linter
  use("mfussenegger/nvim-lint")

  use("mfussenegger/nvim-dap")

  use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }

  use("theHamsta/nvim-dap-virtual-text");
  -- Java jdtls
  use("mfussenegger/nvim-jdtls")

  -- Rose theme
  use({ "rose-pine/neovim", as = "rose-pine" })

  use("tjdevries/colorbuddy.nvim")

  use { "catppuccin/nvim", as = "catppuccin" }

  use("rebelot/kanagawa.nvim")

  use("feline-nvim/feline.nvim")

  -- use("svrana/neosolarized.nvim")

  use({
    -- Telescopik
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    requires = { { "nvim-lua/plenary.nvim" } },
  })

  -- Highlight
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -- NPM package info
  use({
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
  })

  -- Highlight colors
  use({
    "brenoprata10/nvim-highlight-colors",
  })

  -- Commenting code
  use({
    "numToStr/Comment.nvim",
    config = function()
      require("Comment").setup()
    end,
  })

  use("lukas-reineke/indent-blankline.nvim")

  -- im tired
  -- make it pretty baby
  use("neovim/nvim-lspconfig")

  use("stevearc/conform.nvim")

  -- my favret dumb code companion
  -- use({
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = true,
  --         debounce = 75,
  --         keymap = {
  --           accept = "<Tab>",
  --           accept_word = false,
  --           accept_line = false,
  --           next = "<M-]>",
  --           prev = "<M-[>",
  --           dismiss = "<C-]>",
  --         },
  --       },
  --       filetypes = {
  --         yaml = false,
  --         markdown = false,
  --         help = false,
  --         gitcommit = false,
  --         gitrebase = false,
  --         hgcommit = false,
  --         svn = false,
  --         cvs = false,
  --         ["."] = false,
  --       },
  --       copilot_node_command = "node", -- Node.js version must be > 18.x
  --       server_opts_overrides = {},
  --     })
  --   end,
  -- })

  -- nvim tree
  use({
    "nvim-tree/nvim-tree.lua",
    requires = {
      "nvim-tree/nvim-web-devicons",
    },
  })


  -- please please change file import paths when I move files around PLEASE (it's 04:25 AM)
  use {
    "antosha417/nvim-lsp-file-operations",
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua"
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  }

  -- aerial
  use({
    "stevearc/aerial.nvim",
  })

  -- git wrapper
  use("tpope/vim-fugitive")

  -- language servers
  use({
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    requires = {
      --- Uncomment these if you want to manage LSP servers from neovim
      { "williamboman/mason.nvim", version = "^1.0.0" },
      { "williamboman/mason-lspconfig.nvim", version = "^1.0.0" },

      -- LSP Support
      { "neovim/nvim-lspconfig" },
      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "L3MON4D3/LuaSnip" },
    },
  })

  -- use {
  --   "Exafunction/codeium.vim",
  -- }

  if packer_bootstrap then
    require("packer").sync()
  end
end)
