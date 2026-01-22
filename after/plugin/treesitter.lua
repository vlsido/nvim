require("nvim-treesitter").setup({
  ensure_installed = {
    "diff",
    "cpp",
    "c_sharp",
    "javascript",
    "typescript",
    "lua",
    "vim",
    "c",
    "go",
    "java",
    "json",
    "markdown",
    "markdown_inline",
    "html",
    "yaml"
  },

  sync_install = false,

  auto_install = true,

  highlight = {
    enable = true,

    additional_vim_regex_highlighting = false,
  },
})
