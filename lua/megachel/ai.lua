require("codecompanion").setup({
  strategies = {
    name = "copilot",
    model = "gpt-4.1",
    chat = {
      keymaps = {
        send = {
          modes = { n = "<C-s>", v = "<C-s>", i = "<C-s>" },
        },
        close = {
          modes = { n = "<C-;>", v = "<C-;>", i = "<C-;>" },
          opts = {},
        },
      },
    },
  },
  display = {
    chat = {
      window = {
        layout = "vertical", -- float|vertical|horizontal|buffer
        position = "right",  -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)
        border = "single",
        -- height = 0.8,
        width = 0.3,
        relative = "editor",
        -- full_height = true, -- when set to false, vsplit will be used to open the chat buffer vs. botright/topleft vsplit
        sticky = true, -- when set to true and `layout` is not `"buffer"`, the chat buffer will remain opened when switching tabs
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
      },
    },
  },
  extensions = {
    history = {
      enabled = true,
      opts = {
        -- Keymap to open history from chat buffer (default: gh)
        keymap = "gh",
        -- Keymap to save the current chat manually (when auto_save is disabled)
        save_chat_keymap = "sc",
        -- Save all chats by default (disable to save only manually using 'sc')
        auto_save = true,
        -- Number of days after which chats are automatically deleted (0 to disable)
        expiration_days = 0,
        -- Picker interface (auto resolved to a valid picker)
        picker = "telescope", --- ("telescope", "snacks", "fzf-lua", or "default")
        ---Optional filter function to control which chats are shown when browsing
        chat_filter = nil,    -- function(chat_data) return boolean end
        -- Customize picker keymaps (optional)
        picker_keymaps = {
          rename = { n = "r", i = "<M-r>" },
          delete = { n = "d", i = "<M-d>" },
          duplicate = { n = "<C-y>", i = "<C-y>" },
        },
        ---Automatically generate titles for new chats
        auto_generate_title = true,
        title_generation_opts = {
          ---Adapter for generating titles (defaults to current chat adapter)
          adapter = nil,               -- "copilot"
          ---Model for generating titles (defaults to current chat model)
          model = nil,                 -- "gpt-4o"
          ---Number of user prompts after which to refresh the title (0 to disable)
          refresh_every_n_prompts = 0, -- e.g., 3 to refresh after every 3rd user prompt
          ---Maximum number of times to refresh the title (default: 3)
          max_refreshes = 3,
          format_title = function(original_title)
            -- this can be a custom function that applies some custom
            -- formatting to the title.
            return original_title
          end,
        },
        ---On exiting and entering neovim, loads the last chat on opening chat
        continue_last_chat = true,
        ---When chat is cleared with `gx` delete the chat from history
        delete_on_clearing_chat = false,
        ---Directory path to save the chats
        dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
        ---Enable detailed logging for history extension
        enable_logging = false,

        -- Summary system
        summary = {
          -- Keymap to generate summary for current chat (default: "gcs")
          create_summary_keymap = "gcs",
          -- Keymap to browse summaries (default: "gbs")
          browse_summaries_keymap = "gbs",

          generation_opts = {
            adapter = nil,               -- defaults to current chat adapter
            model = nil,                 -- defaults to current chat model
            context_size = 90000,        -- max tokens that the model supports
            include_references = true,   -- include slash command content
            include_tool_outputs = true, -- include tool execution results
            system_prompt = nil,         -- custom system prompt (string or function)
            format_summary = nil,        -- custom function to format generated summary e.g to remove <think/> tags from summary
          },
        },

        -- Memory system (requires VectorCode CLI)
        memory = {
          -- Automatically index summaries when they are generated
          auto_create_memories_on_summary_generation = true,
          -- Path to the VectorCode executable
          vectorcode_exe = "vectorcode",
          -- Tool configuration
          tool_opts = {
            -- Default number of memories to retrieve
            default_num = 10,
          },
          -- Enable notifications for indexing progress
          notify = true,
          -- Index all existing memories on startup
          -- (requires VectorCode 0.6.12+ for efficient incremental indexing)
          index_on_startup = false,
        },
      },
    },
  },
})

vim.keymap.set({ "n", "v" }, "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<leader>a", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])
