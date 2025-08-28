-- lsp related configuration

require("mason").setup()
require("mason-lspconfig").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'
local mason = require 'mason-lspconfig'

-- lsp servers
local servers = {
	-- clangd = {},
	gopls = {},
	-- python_lsp_server = {},
	pyright = {},
	json_lsp = {},
	tflint = {},
	terraform_ls = {},
	rome = {},
	sqls = {},
	-- yaml_lsp_server = {},
	-- rust_analyzer = {},
	-- tsserver = {},

	sumneko_lua = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}


mason.setup()
-- Note: `nvim-lspconfig` needs to be in 'runtimepath' by the time you set up mason-lspconfig.nvim
mason_lspconfig.setup {
  ensure_installed = { "pyright" }
}

-- mason_lspconfig.setup_handlers {
-- 	function(server_name)
-- 		require('lspconfig')[server_name].setup {
-- 			capabilities = capabilities,
-- 			on_attach = on_attach,
-- 			settings = servers[server_name],
-- 		}
-- 	end,
-- }


-- Autocomplete
local cmp = require 'cmp'
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
cmp.setup {
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert {
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		-- ['<C-Space>'] = cmp.mapping.complete(),
		['<C-Space>'] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		},
		['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
			end
		end, { 'i', 's' }),
		['<S-Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				cmp_ultisnips_mappings.jump_backwards(fallback)
			end
		end, { 'i', 's' }),
	},
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' },
	},
}

-- formatters and linters
local null_ls = require("null-ls")
null_ls.setup({
	sources = {
		-- python
		null_ls.builtins.diagnostics.pylint.with({
			diagnostics_postprocess = function(diagnostic)
				diagnostic.code = diagnostic.message_id
			end,
		}),
		null_ls.builtins.formatting.isort,
		null_ls.builtins.formatting.black,

		-- go
		null_ls.builtins.formatting.gofumpt,
		null_ls.builtins.diagnostics.golangci_lint,

		-- yaml
		null_ls.builtins.formatting.yamlfmt,

		-- json
		null_ls.builtins.formatting.fixjson,

		-- typescript, javascript, markdown, html, json, etc
		-- null_ls.builtins.formatting.prettier,
		null_ls.builtins.code_actions.xo,
		null_ls.builtins.formatting.rome,
		null_ls.builtins.diagnostics.sqlfluff.with({
			extra_args = { "--dialect", "postgres", "--ignore", "templating", "--config", "/home/javier/.config/nvim/conf/sqlfluff.cfg" },
		}),
		-- null_ls.builtins.formatting.sqlfmt,
	},
})


-- diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = {
      spacing = 6,
    },
    -- Use a function to dynamically turn signs off
    -- and on, using buffer local variables
    signs = function(namespace, bufnr)
      return vim.b[bufnr].show_signs == true
    end,
    -- Disable a feature
    update_in_insert = false,
  }
)

-- typescript specific config
-- sudo npm install -g typescript typescript-language-server
require'lspconfig'.tsserver.setup {}
