return {

	-- Floating terminal (may be unnecesasry)
	"voldikss/vim-floaterm",
	keys = {
		{ "<leader>xx", "<cmd>FloatermToggle<cr>", desc = "toggle" },
		{ "<leader>xf", "<cmd>FloatermNew  --width=0.95 --height=0.95  vifm<cr>", desc = "vifm" },
		{ "<leader>xt", "<cmd>FloatermNew  --width=0.95 --height=0.95 bpytop<cr>", desc = "bpytop" },
		{ "<leader>xh", "<cmd>FloatermNew  --width=0.95 --height=0.95 htop<cr>", desc = "htop" },
		{ "<leader>xP", "<cmd>FloatermNew ipython<cr>", desc = "python" },
		{ "<leader>xn", "<cmd>FloatermNext<cr>", desc = "next" },
		{ "<leader>xp", "<cmd>FloatermPrev<cr>", desc = "prev" },
		{ "<leader>xr", "<cmd>FloatermSend<cr>", desc = "send" },
		{ "<leader>xg", "<cmd>FloatermNew  --width=0.95 --height=0.95 lazygit<cr>", desc = "lazygit" },
		{ "<leader>x]", "<cmd>FloatermNext<cr>", desc = "next" },
		{ "<leader>x[", "<cmd>FloatermPrev<cr>", desc = "prev" },
		{ "<leader>x\\", "<cmd>FloatermNew --wintype=normal --position=right<cr>", desc = "right" },
		{ "<leader>x-", "<cmd>FloatermNew --wintype=normal --height=0.3 --position=bottom<cr>", desc = "bottom" },
		{ "<leader>xt", "<cmd>FloatermToggle<cr>", desc = "terminal" },
	},
}