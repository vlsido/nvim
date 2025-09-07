require("codecompanion").setup({
  strategies = {
    name = "copilot",
    model = "gpt-4.1",
  },
  display = {
    chat = {
      window = {
        layout = "vertical", -- float|vertical|horizontal|buffer
        position = "right",  -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)
        border = "single",
        -- height = 0.8,
        width = 0.25,
        relative = "editor",
        -- full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
        -- sticky = false,     -- when set to true and `layout` is not `"buffer"`, the chat buffer will remain opened when switching tabs
        opts = {
          breakindent = true,
          cursorcolumn = false,
          cursorline = false,
          foldcolumn = "0",
          linebreak = true,
          list = false,
          numberwidth = 1,
          signcolumn = "no",
          spell = false,
          wrap = true,
        },
      }
    }
  }
})
