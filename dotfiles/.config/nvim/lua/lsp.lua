-- lsp related configuration

require("mason").setup()
require("mason-lspconfig").setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

-- lsp servers
local servers = {
	-- clangd = {},
	-- gopls = {},
	python_lsp_server = {},
	json_lsp = {},
	-- rust_analyzer = {},
	-- tsserver = {},

	sumneko_lua = {
		Lua = {
			workspace = { checkThirdParty = false },
			telemetry = { enable = false },
		},
	},
}

mason_lspconfig.setup_handlers {
	function(server_name)
		require('lspconfig')[server_name].setup {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = servers[server_name],
		}
	end,
}


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
		['<C-Space>'] = cmp.mapping.complete(),
		['<CR>'] = cmp.mapping.confirm {
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

		-- json
		null_ls.builtins.formatting.fixjson,
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
