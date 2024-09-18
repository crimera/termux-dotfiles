return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
		"saadparwaiz1/cmp_luasnip",
		"L3MON4D3/LuaSnip",
	},
	config = function()
		-- Add additional capabilities supported by nvim-cmp
		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		local lspconfig = require("lspconfig")

		-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
		local servers = { "lua_ls", "clangd", "zls", "taplo", "ruff", "pylsp", "gopls", "rust_analyzer" }

		for _, lsp in ipairs(servers) do
			lspconfig[lsp].setup({

				-- on_attach = my_custom_on_attach,
				capabilities = capabilities,
			})
		end

		lspconfig.eslint.setup({})

		-- luasnip setup
		local luasnip = require("luasnip")

		-- nvim-cmp setup
		local cmp = require("cmp")
		cmp.setup({
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			selection = {
				behavior = cmp.SelectBehavior.Select,
				auto_select = true,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-u>"] = cmp.mapping.scroll_docs(-4), -- Up
				["<C-d>"] = cmp.mapping.scroll_docs(4), -- Down
				-- C-b (back) C-f (forward) for snippet placeholder navigation.

				["<C-Space>"] = cmp.mapping.complete(),
				["<CR>"] = cmp.mapping.confirm({

					behavior = cmp.ConfirmBehavior.Replace,
					select = true,
				}),
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = {
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
				{ name = "buffer" },
				{ name = "path" },
			},
		})
	end,
}
