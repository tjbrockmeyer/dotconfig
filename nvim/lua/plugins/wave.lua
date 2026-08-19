return {
	"tjbrockmeyer/wave.nvim",
	name = "wave.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		local wave = require("wave")
		wave.setup({})
		vim.keymap.set("n", "<leader>wf", function()
			wave.run("auto_function")
		end, { desc = "Handwave a function body" })
		vim.keymap.set("n", "<leader>ws", function()
			wave.run("auto_snippet")
		end, { desc = "Handwave a code snippet" })
		vim.keymap.set("n", "<leader>wc", function()
			wave.run("cancel")
		end, { desc = "Cancel a handwave job" })
	end,
}
