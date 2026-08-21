return {
	"tjbrockmeyer/wave.nvim",
	name = "wave.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		local wave = require("wave")
		wave.setup({})
		vim.keymap.set("n", "<leader>wa", function()
			wave.run("ask")
		end, { desc = "Ask about something" })
		vim.keymap.set("n", "<leader>ws", function()
			wave.run("auto_snippet")
		end, { desc = "Handwave a code snippet" })
		vim.keymap.set("n", "<leader>wr", function()
			wave.run("review")
		end, { desc = "Review committed changes" })
		vim.keymap.set("n", "<leader>wc", function()
			wave.run("cancel")
		end, { desc = "Cancel a handwave job" })
	end,
}
