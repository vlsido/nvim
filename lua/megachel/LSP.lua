local lsp_zero = require("lsp-zero")

lsp_zero.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  vim.keymap.set("n", "gd", function()
    vim.lsp.buf.definition()
  end, opts)
  vim.keymap.set("n", "K", function()
    vim.lsp.buf.hover()
  end, opts)
  vim.keymap.set("n", "<leader>vws", function()
    vim.lsp.buf.workspace_symbol()
  end, opts)
  vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float()
  end, opts)
  vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_next()
  end, opts)
  vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_prev()
  end, opts)
  vim.keymap.set("n", "<leader>vca", function()
    vim.lsp.buf.code_action()
  end, opts)
  vim.keymap.set("n", "<leader>vrf", function()
    vim.lsp.buf.references()
  end, opts)
  vim.keymap.set("n", "<leader>vrn", function()
    vim.lsp.buf.rename()
  end, opts)
  vim.keymap.set("i", "<C-h>", function()
    vim.lsp.buf.signature_help()
  end, opts)
end)

require("mason").setup({})

require("mason-lspconfig").setup({
  ensure_installed = {
    "eslint",
    "csharp_ls",
    "lua_ls",
    "vimls",
    "gradle_ls",
    "jdtls",
    "clangd",
    "cmake",
    "golangci_lint_ls",
    "gopls",
  },
})

require("mason-lspconfig").setup_handlers({
  function(server_name)
    require("lspconfig")[server_name].setup({})
  end,

  ["lua_ls"] = function()
    local lua_opts = lsp_zero.nvim_lua_ls()
    require("lspconfig").lua_ls.setup(lua_opts)
  end,
  ["gopls"] = function()
    require("lspconfig").gopls.setup({
      cmd = { "gopls" },
      filetypes = { "go", "gomod", "gowork", "gotmpl" },
      root_dir = require("lspconfig/util").root_pattern("go.work", "go_mod", ".git"),
      settings = {
        gopls = {
          completeUnimported = true,
        },
      },
    })
  end,

  ["clangd"] = function()
    require("lspconfig").clangd.setup({
      on_attach = function(client, bufnr)
        local function buf_set_keymap(...)
          vim.api.nvim_buf_set_keymap(bufnr, ...)
        end
        -- Mappings.
        local opts = { noremap = true, silent = true }

        -- Format the current buffer using clangd with CTRL+F
        buf_set_keymap("n", "<C-f>", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", opts)
      end,
    })
  end,
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  sources = {
    { name = "path" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "codeium" }
  },
  formatting = lsp_zero.cmp_format(),
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
})
