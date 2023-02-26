local dap_types = { "python", "lua", "c", "cpp", "php", "java", "js" }
local function dapuiconfig()
	require("dapui").setup({
		icons = { expanded = "▾", collapsed = "▸" },
		mappings = {
			-- Use a table to apply multiple mappings
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
		},
		floating = {
			max_height = nil, -- These can be integers or a float between 0 and 1.
			max_width = nil, -- Floats will be treated as percentage of your screen.
			border = "single", -- Border style. Can be "single", "double" or "rounded"
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		windows = { indent = 1 },

		layouts = {
			{
				elements = {
					"scopes",
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 40,
				position = "left",
			},
			{
				elements = {
					"repl",
					"console",
				},
				size = 10,
				position = "bottom",
			},
		},
	})
	local dap, dapui = require("dap"), require("dapui")
	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end
	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end
	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end
return {
	-- Debugging
	{ "jbyuki/one-small-step-for-vimkind", ft = { "lua" } },
	{
		"mfussenegger/nvim-dap",
		ft = dap_types,
		keys = {
			{ "<F3>", "<cmd>DebugScopes<CR>", mode = { "n" } },
			{ "<F4>", "<cmd>DebugHover<CR>", mode = { "n" } },
			{ "<S-F4>", "<cmd>DebugVHover<CR>", mode = { "n" } },
			{ "<F5>", "<cmd>DebugContinue<CR>", mode = { "n" } },
			{ "<S-F5>", "<cmd>DebugLast<CR>", mode = { "n" } },
			{ "<C-F5>", "<cmd>DebugPause<CR>", mode = { "n" } },
			{ "<F6>", "<cmd>DebugToggleRepl<CR>", mode = { "n" } },
			{ "<F7>", "<cmd>DebugUp<CR>", mode = { "n" } },
			{ "<F8>", "<cmd>DebugDown<CR>", mode = { "n" } },
			{ "<A-F8>", "<cmd>DebugSetExceptionBreakpointsDefault<CR>", mode = { "n" } },
			{ "<S-F8>", "<cmd>DebugSetExceptionBreakpointsRaised<CR>", mode = { "n" } },
			{ "<C-F8>", "<cmd>DebugSetExceptionBreakpointsUncaught<CR>", mode = { "n" } },
			{ "<F9>", "<cmd>DebugToggleBreakpoint<CR>", mode = { "n" } },
			{ "<A-F9>", "<cmd>DebugLogPoint<CR>", mode = { "n" } },
			{ "<S-F9>", "<cmd>DebugConditionalBreakpoint<CR>", mode = { "n" } },
			{ "<C-F9>", "<cmd>DebugListBreakpoints<CR>", mode = { "n" } },
			{ "<F10>", "<cmd>DebugStepOver<CR>", mode = { "n" } },
			{ "<F11>", "<cmd>DebugStepInto<CR>", mode = { "n" } },
			{ "<S-F11>", "<cmd>DebugStepOut<CR>", mode = { "n" } },
			{ "<F12>", "<cmd>DebugStop<CR>", mode = { "n" } },
			{ "<leader>td", "<cmd>lua require('dap-python').test_method()<cr>", mode = { "n" }, desc = "debug" },
			{ "<leader>dt", "<cmd>lua require('dapui').toggle()<cr>", mode = { "n" }, desc = "toggle breakpoint" },
			{ "<leader>de", "<Cmd>lua require('dapui').eval()<CR>", mode = { "n" }, desc = "evaluate" },
			{ "<leader>db", "<cmd>DebugToggleBreakpoint<cr>", mode = { "n" }, desc = "toggle breakpoint" },
			{ "<leader>dl", "<cmd>DebugStepInto<cr>", mode = { "n" }, desc = "step into" },
			{ "<leader>dh", "<cmd>DebugStepOut<cr>", mode = { "n" }, desc = "step out" },
			{ "<leader>dj", "<cmd>DebugStepOver<cr>", mode = { "n" }, desc = "step over" },
			{ "<leader>dr", "<cmd>DebugToggleRepl<cr>", mode = { "n" }, desc = "toggle repl" },
			{ "<leader>dg", "<cmd>DebugStart<cr>", mode = { "n" }, desc = "start/continue" },
			{ "<leader>dk", "<cmd>DebugHover<cr>", mode = { "n" }, desc = "hover" },
			{ "<leader>ds", "<cmd>DebugScopes<cr>", mode = { "n" }, desc = "scopes" },
			{ "<leader>dv", "<cmd>DebugVHover<cr>", mode = { "n" }, desc = "visual-hover" },
			{ "<leader>dz", "<cmd>DebugLast<cr>", mode = { "n" }, desc = "last" },
			{ "<leader>dp", "<cmd>DebugPause<cr>", mode = { "n" }, desc = "pause" },
			{ "<leader>du", "<cmd>DebugUp<cr>", mode = { "n" }, desc = "up" },
			{ "<leader>dd", "<cmd>DebugDown<cr>", mode = { "n" }, desc = "down" },
			{
				"<leader>dD",
				"<cmd>DebugSetExceptionBreakpointsDefault<cr>",
				mode = { "n" },
				desc = "exceptions-default",
			},
			{ "<leader>dN", "<cmd>DebugSetExceptionBreakpointsNone<cr>", mode = { "n" }, desc = "exceptions-none" },
			{ "<leader>dR", "<cmd>DebugSetExceptionBreakpointsRaised<cr>", mode = { "n" }, desc = "exceptions-raised" },
			{
				"<leader>dU",
				"<cmd>DebugSetExceptionBreakpointsUncaught<cr>",
				mode = { "n" },
				desc = "exceptions-uncaught",
			},
			{ "<leader>dL", "<cmd>DebugLogPoint<cr>", mode = { "n" }, desc = "log" },
			{ "<leader>dC", "<cmd>DebugConditionalBreakpoint<cr>", mode = { "n" }, desc = "conditional breakpoint" },
		},
		config = function()
			vim.fn.sign_define("DapBreakpoint", { text = "🔸", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapBreakpointRejected", { text = "💀", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapLogPoint", { text = "📚", texthl = "", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "🟢", texthl = "", linehl = "", numhl = "" })
		end,
	},
	{
		"Pocco81/DAPInstall.nvim",
		cmd = { "DIInstall", "DIUninstall", "DIList" },
		config = function()
			local dap_install = require("dap-install")
			local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
			for _, debugger in ipairs(dbg_list) do
				dap_install.config(debugger)
			end
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		ft = dap_types,
		config = dapuiconfig,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		ft = dap_types,
		-- dependencies = {{"mfussenegger/nvim-dap", lazy=true},{ "nvim-telescope/telescope.nvim", opt=true}},
		config = dapuiconfig,
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		ft = dap_types,
		-- dependencies = {{"mfussenegger/nvim-dap", lazy=true},{ "nvim-telescope/telescope.nvim", opt=true}},
		-- dependencies = {{"mfussenegger/nvim-dap", lazy=true}},
		config = function()
			vim.g.dap_virtual_text = true
		end,
	},
	{
		"mfussenegger/nvim-dap-python",
		ft = { "python" },
		-- dependencies = "mfussenegger/nvim-dap",
		config = function()
			local dappy = require("dap-python")
			-- print(vim.g["python3_host_prog"])
			dappy.setup(vim.g["python3_host_prog"])
			dappy.test_runner = "pytest"
		end,
	},
}