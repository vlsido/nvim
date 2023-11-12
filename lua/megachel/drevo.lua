 
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.api.nvim_set_keymap('n', '<C-h>', ':NvimTreeToggle<cr>', { silent = true, noremap = true })
vim.api.nvim_set_keymap('n', '<C-c>', ':NvimTreeFocus<cr>', { silent = true, noremap = true })

local function attachThisLeaf(bufnr)
    local api = require 'nvim-tree.api'

    local function opts(desc)
        return { desc = 'nvim-tree' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- my mappings
    vim.keymap.set('n', '<k8>', api.node.navigate.sibling.prev, opts('Prev file'))
    vim.keymap.set('i', '<k8>', api.node.navigate.sibling.prev, opts('Prev file'))
    vim.keymap.set('n', '<k2>', api.node.navigate.sibling.next, opts('Next file'))
    vim.keymap.set('i', '<k2>', api.node.navigate.sibling.next, opts('Next file'))
end


-- OR setup with some options
require("nvim-tree").setup({
    on_attach = attachThisLeaf,
  sort_by = "case_sensitive",
  view = {
    width = 20,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
