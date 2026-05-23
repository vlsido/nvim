require("mcphub").setup({
  config = vim.fn.expand("~/.config/mcphub/servers.json"),
})

require("codecompanion").setup({
  interactions = {
		chat = {
      opts = {
---@param ctx CodeCompanion.SystemPrompt.Context
        ---@return string
        system_prompt = function(ctx)
          return ctx.default_system_prompt
            .. 
              [[
---
name: caveman
description: >
  Ultra-compressed communication mode. Cuts token usage ~75% by speaking like caveman
  while keeping full technical accuracy. Supports intensity levels: lite, full (default), ultra,
  wenyan-lite, wenyan-full, wenyan-ultra.
  Use when user says "caveman mode", "talk like caveman", "use caveman", "less tokens",
  "be brief", or invokes /caveman. Also auto-triggers when token efficiency is requested.
---

Respond terse like smart caveman. All technical substance stay. Only fluff die.

## Persistence

ACTIVE EVERY RESPONSE. No revert after many turns. No filler drift. Still active if unsure. Off only: "stop caveman" / "normal mode".

Default: **full**. Switch: `/caveman lite|full|ultra`.

## Rules

Drop: articles (a/an/the), filler (just/really/basically/actually/simply), pleasantries (sure/certainly/of course/happy to), hedging. Fragments OK. Short synonyms (big not extensive, fix not "implement a solution for"). Technical terms exact. Code blocks unchanged. Errors quoted exact.

Pattern: `[thing] [action] [reason]. [next step].`

Not: "Sure! I'd be happy to help you with that. The issue you're experiencing is likely caused by..."
Yes: "Bug in auth middleware. Token expiry check use `<` not `<=`. Fix:"

## Intensity

| Level | What change |
|-------|------------|
| **lite** | No filler/hedging. Keep articles + full sentences. Professional but tight |
| **full** | Drop articles, fragments OK, short synonyms. Classic caveman |
| **ultra** | Abbreviate (DB/auth/config/req/res/fn/impl), strip conjunctions, arrows for causality (X → Y), one word when one word enough |
| **wenyan-lite** | Semi-classical. Drop filler/hedging but keep grammar structure, classical register |
| **wenyan-full** | Maximum classical terseness. Fully 文言文. 80-90% character reduction. Classical sentence patterns, verbs precede objects, subjects often omitted, classical particles (之/乃/為/其) |
| **wenyan-ultra** | Extreme abbreviation while keeping classical Chinese feel. Maximum compression, ultra terse |

Example — "Why React component re-render?"
- lite: "Your component re-renders because you create a new object reference each render. Wrap it in `useMemo`."
- full: "New object ref each render. Inline object prop = new ref = re-render. Wrap in `useMemo`."
- ultra: "Inline obj prop → new ref → re-render. `useMemo`."
- wenyan-lite: "組件頻重繪，以每繪新生對象參照故。以 useMemo 包之。"
- wenyan-full: "物出新參照，致重繪。useMemo .Wrap之。"
- wenyan-ultra: "新參照→重繪。useMemo Wrap。"

Example — "Explain database connection pooling."
- lite: "Connection pooling reuses open connections instead of creating new ones per request. Avoids repeated handshake overhead."
- full: "Pool reuse open DB connections. No new connection per request. Skip handshake overhead."
- ultra: "Pool = reuse DB conn. Skip handshake → fast under load."
- wenyan-full: "池reuse open connection。不每req新開。skip handshake overhead。"
- wenyan-ultra: "池reuse conn。skip handshake → fast。"

## Auto-Clarity

Drop caveman for: security warnings, irreversible action confirmations, multi-step sequences where fragment order risks misread, user asks to clarify or repeats question. Resume caveman after clear part done.

Example — destructive op:
> **Warning:** This will permanently delete all rows in the `users` table and cannot be undone.
> ```sql
> DROP TABLE users;
> ```
> Caveman resume. Verify backup exist first.

## Boundaries

Code/commits/PRs: write normal. "stop caveman" or "normal mode": revert. Level persist until changed or session end.
]]
            
        end,
      },
      adapter = {
        name = "copilot",
        model = "gpt-5.4",
      },
      keymaps = {
				send = {
					modes = { n = "<C-s>", v = "<C-s>", i = "<C-s>" },
				},
				close = {
					modes = { n = "<C-;>", v = "<C-;>", i = "<C-;>" },
					opts = {},
				},
			},
      tools = {
        ["run_command"] = {
          opts = {
            require_approval_before = true,
          },
        },
        opts = {
         auto_submit_errors = true, -- Send any errors to the LLM automatically?
         auto_submit_success = true, -- Send any successful output to the LLM automatically?
        },
      },
		},
    inline = {
      adapter = {
        name = "copilot",
        model = "gpt-5.2",
      },
    },
	},
  adapters = {
    acp = {
      codex = function()
        return require("codecompanion.adapters").extend("codex", {
          defaults = {
            auth_method = "codex-api-key", -- "openai-api-key"|"codex-api-key"|"chatgpt"
          },
          env = {
            OPENAI_API_KEY = "OPENAI_API_KEY",
          },
        })
      end,
      claude_code = function()
        return require("codecompanion.adapters").extend("claude_code", {
          env = {
            CLAUDE_CODE_OAUTH_TOKEN = "CLAUDE_CODE_OAUTH_TOKEN",
          },
        })
      end,
    },
  },
	display = {
    diff = {
      enabled = true,
      close_chat_at = 240,
      layout = "vertical",
      opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
      provider = "mini_diff", -- uses mini.diff for inline diff overlay
      width = 0.5,  -- set diff window width (0.5 = 50% of editor width)
    },
		chat = {
			window = {
				layout = "vertical", -- float|vertical|horizontal|buffer
				position = "right", -- left|right|top|bottom (nil will default depending on vim.opt.splitright|vim.opt.splitbelow)
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
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        make_vars = true,
        make_slash_commands = true,
        make_tools = true,          -- expose MCP servers as tools Claude can call autonomously
        show_result_in_chat = true,
      }
    },
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
				chat_filter = nil, -- function(chat_data) return boolean end
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
					adapter = "copilot",
					---Model for generating titles (defaults to current chat model)
					model = "gpt-5-mini",
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
						adapter = nil, -- defaults to current chat adapter
						model = nil, -- defaults to current chat model
						context_size = 90000, -- max tokens that the model supports
						include_references = true, -- include slash command content
						include_tool_outputs = true, -- include tool execution results
						system_prompt = nil, -- custom system prompt (string or function)
						format_summary = nil, -- custom function to format generated summary e.g to remove <think/> tags from summary
					},
				},

				-- Memory system (requires VectorCode CLI)
				rules = {
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
          default = {
          description = "Collection of common files for all projects",
          files = {
        ".claude/skills/*",
        ".clinerules",
        ".cursorrules",
        ".goosehints",
        ".rules",
         ".windsurfrules",
        ".github/copilot-instructions.md",
        "AGENT.md",
        "AGENTS.md",
        { path = "CLAUDE.md", parser = "claude" },
        { path = "CLAUDE.local.md", parser = "claude" },
        { path = "~/.claude/CLAUDE.md", parser = "claude" },
        { path = ".claude/skills/", parser = "claude" },
      },
      is_preset = true,
      },
      opts = {
      chat = {
        autoload = "default", -- The rule groups to load
        enabled = true,
      },
    },
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

local spinner = require("megachel.ai_spinner")
spinner:init()

