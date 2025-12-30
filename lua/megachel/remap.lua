vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
	require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
	require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

local dap = require("dap")

vim.keymap.set("n", "b", dap.toggle_breakpoint)

vim.keymap.set("n", "<space>?", function()
	require("dapui").eval(nil, { enter = true })
end)
vim.keymap.set("n", "<F1>", dap.continue)
vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<F5>", dap.step_back)
vim.keymap.set("n", "<F12>", dap.restart)

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-l>", "<nop>")
vim.keymap.set("n", "cc", "<nop>")
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-n>", "<cmd>cclose<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- /* Windows size */
-- NOPs
vim.keymap.set("n", "<C-v>", "<nop>")
vim.keymap.set("n", "<C-v>", "<nop>")
vim.keymap.set("n", "<", "<nop>")
vim.keymap.set("n", ">", "<nop>")
vim.keymap.set("n", ".", "<nop>")
vim.keymap.set("n", ";", "<nop>")
vim.keymap.set("n", "'", "<nop>")
vim.keymap.set("n", "<leader><Left>", "<nop>")
vim.keymap.set("n", "<leader><Right>", "<nop>")
vim.keymap.set("n", "<leader><Up>", "<nop>")
vim.keymap.set("n", "<leader><Down>", "<nop>")
-- Mappings
vim.keymap.set({ "n", "v" }, "<", "<C-w>10<")
vim.keymap.set({ "n", "v" }, ">", "<C-w>10>")
vim.keymap.set({ "n", "v" }, "}", "<C-w>3+")
vim.keymap.set({ "n", "v" }, "{", "<C-w>3-")
vim.keymap.set({ "n", "v" }, "{", "<C-w>3-")
vim.keymap.set({ "n", "v" }, "{", "<C-w>3-")
vim.keymap.set("n", "<leader><Left>", "<C-w>h")
vim.keymap.set("n", "<leader><Right>", "<C-w>l")
vim.keymap.set("n", "<leader><Up>", "<C-w>k")
vim.keymap.set("n", "<leader><Down>", "<C-w>l")
-- [END] Windows size

-- Delete without cutting
vim.keymap.set({ "n", "v" }, "d", "<nop>")
vim.keymap.set({ "n", "v" }, "d", "<Del>")

-- Moving cursor to start and end of line
vim.keymap.set({ "n", "v" }, "<C-,>", "<nop>")
vim.keymap.set({ "n", "v" }, "<C-.>", "<nop>")

vim.keymap.set({ "n", "v" }, "<C-,>", "^")
vim.keymap.set({ "n", "v" }, "<C-.>", "$")

vim.keymap.set("i", "<C-,>", "<C-c>^i")
vim.keymap.set("i", "<C-.>", "<C-c>$i")

-- Some crazy maps
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end)

vim.keymap.set({ "n", "v" }, "p", [["0p]])
vim.keymap.set({ "n", "v" }, "x", [["0d]])

-- Delete without cutting
vim.keymap.set({ "n", "v" }, "d", "<nop>")
vim.keymap.set({ "n", "v" }, "d", "<Del>")

vim.keymap.set("n", "<CR>", "i", { noremap = true })

vim.keymap.set("n", "<C-]>", "gt", { noremap = true })

vim.keymap.set("n", "<C-[>", "gT", { noremap = true })

vim.keymap.set("n", "<C-x>", ":close<CR>", { noremap = true, silent = true })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true, desc = "Exit terminal mode" })

-- Put this in your init.lua or a plugin/config file
vim.keymap.set("i", "<C-s>", function()
	vim.lsp.buf.hover()
end, { desc = "LSP Hover (insert mode)" })

vim.keymap.set("v", "<C-v>", '"_dP', { noremap = true })
vim.keymap.set("v", "<C-v>", "<C-r>+", { noremap = true })
