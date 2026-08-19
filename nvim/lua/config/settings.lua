local load_settings = function()
	local global_local = {
		termguicolors = true,
		errorbells = false,
		visualbell = true,
		virtualedit = "onemore",
		wildignorecase = true,
		backup = false,
		writebackup = false,
		undofile = false,
		swapfile = false,
		timeout = true,
		timeoutlen = 500,
		updatetime = 1000,
		redrawtime = 100,
		incsearch = true,
		wrap = true,
		wrapscan = true,
		splitbelow = true,
		splitright = true,
		showtabline = 1,
		winwidth = 30,
		previewheight = 12,
		helpheight = 12,
		showcmdloc = "statusline",
		title = true,
		textwidth = 120,
		breakindent = true,
		number = true,
		relativenumber = true,
		colorcolumn = "110",
		cursorline = true,
		splitkeep = "screen",
		expandtab = true,
		tabstop = 2,
		softtabstop = -1,
		shiftwidth = 0,
	}

	for k, v in pairs(global_local) do
		vim.o[k] = v
	end

	-- copy to clipboard
	vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
	vim.keymap.set("n", "<leader>Y", [["+Y]])
end

load_settings()
