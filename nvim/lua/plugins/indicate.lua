return {
	{
		"tjbrockmeyer/indicate.nvim",
		name = "indicate",
		cmd = { "Indicate" },
		keys = {
			{ "<leader>I", "<cmd>Indicate<cr>", desc = "Toggle Indicate panel" },
		},
		opts = {},
		config = function(_, opts)
			require("indicate").setup(opts)
		end,
	},
}
