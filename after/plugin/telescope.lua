local actions = require("telescope.actions")

local open_after_tree = function(prompt_bufnr)
  vim.defer_fn(function()
    actions.select_default(prompt_bufnr)
  end, 100) -- Delay allows filetype and plugins to settle before opening
end

require("telescope").setup({
  defaults = {
    layout_strategy = "vertical",
    layout_config = {
      height = 0.95,
      width = 0.95,
      prompt_position = "bottom",
      preview_cutoff = 1, -- always show preview if possible
      preview_height = 0.5,
    },
    mappings = {
      i = { ["<CR>"] = open_after_tree },
      n = { ["<CR>"] = open_after_tree },
    },
  },
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>fs", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
