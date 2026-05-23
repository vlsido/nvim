require("telescope").setup({
	 defaults = {
    layout_strategy = "vertical",
    layout_config = {
      width = 0.95,
      height = 0.95,

      vertical = {
        prompt_position = "bottom",
        preview_cutoff = 1, -- always show preview if possible
        preview_height = 0.5, -- preview below results (50% of picker)
      },
    },
	},
})

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<C-p>", builtin.git_files, {})
vim.keymap.set("n", "<leader>fs", function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
