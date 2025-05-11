require("nvim-treesitter.configs").setup({
  ensure_installed = { "diff", "cpp", "c_sharp", "javascript", "typescript", "lua", "vim", "c", "go", "java", "json" },

  sync_install = false,

  auto_install = true,

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = false,
  },
})
