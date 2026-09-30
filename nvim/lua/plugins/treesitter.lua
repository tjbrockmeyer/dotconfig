return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	-- Pin a known-good main commit (Neovim 0.12+ rewrite). Bump intentionally.
	commit = "910fdf6f49e9dee7e7257c7d11a76b040fdfb9de",
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
			"groovy",
		}

		-- Async no-op for already-installed parsers; :TSUpdate (build) keeps revisions in sync.
		ts.install(parsers)

		-- Jenkinsfile is detected as filetype "Jenkinsfile"; map it to the groovy parser.
		vim.treesitter.language.register("groovy", "Jenkinsfile")

		-- Use global options (vim.o), not vim.wo[0][0]. The latter only applies to the
		-- current window+buffer pair, so `nvim file` gets treesitter folds while files
		-- opened later (e.g. from netrw) fall back to foldmethod=manual.
		-- foldlevel/foldlevelstart=99 keeps folds available but open by default.
		vim.o.foldmethod = "expr"
		vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99

		-- Highlighting/indent are not auto-enabled on main. pcall so buffers without a
		-- parser (help, netrw, etc.) do not error; avoid precomputing FileType patterns
		-- which races async installs and misses registered aliases (e.g. bash -> sh).
		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				local ok = pcall(vim.treesitter.start)
				if ok then
					vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
