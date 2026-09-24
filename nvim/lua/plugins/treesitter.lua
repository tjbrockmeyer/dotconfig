return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")
		local parsers = {
			"json",
			"javascript",
			"typescript",
			"tsx",
			"yaml",
			"html",
			"css",
			"markdown",
			"markdown_inline",
			"bash",
			"lua",
			"vim",
			"dockerfile",
			"gitignore",
			"c",
			"rust",
			"vimdoc",
			"go",
			"templ",
			"hurl",
			"bash",
		}

		for _, parser in ipairs(parsers) do
			ts.install(parser)
		end

		-- Not every tree-sitter parser is the same as the file type detected
		-- So the patterns need to be registered more cleverly
		local patterns = {}
		for _, parser in ipairs(parsers) do
			local parser_patterns = vim.treesitter.language.get_filetypes(parser)
			for _, pp in pairs(parser_patterns) do
				table.insert(patterns, pp)
			end
		end

		vim.treesitter.language.register("groovy", "Jenkinsfile")

		-- Use global options (vim.o), not vim.wo[0][0]. The latter only applies to the
		-- current window+buffer pair, so `nvim file` gets treesitter folds while files
		-- opened later (e.g. from netrw) fall back to foldmethod=manual.
		-- foldlevel/foldlevelstart=99 keeps folds available but open by default.
		vim.o.foldmethod = "expr"
		vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99

		vim.api.nvim_create_autocmd("FileType", {
			pattern = patterns,
			callback = function()
				vim.treesitter.start()
			end,
		})
	end,
}
