local dap_types = { "python", "lua", "c", "cpp", "php", "java", "js" }
return {
	-- Debugging
	"jbyuki/one-small-step-for-vimkind",
	{
		"mfussenegger/nvim-dap",
		ft = dap_types,
		config = function()
			require("yasser.debug.dapcfg")
		end,
	},
	{
		"Pocco81/DAPInstall.nvim",
		cmd = { "DIInstall", "DIUninstall", "DIList" },
		config = function()
			require("yasser.debug.dapinstall")
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		ft = dap_types,
		config = function()
			require("yasser.debug.dapui")
		end,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		ft = dap_types,
		-- dependencies = {{"mfussenegger/nvim-dap", lazy=true},{ "nvim-telescope/telescope.nvim", opt=true}},
		config = function()
			require("telescope").load_extension("dap")
		end,
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
            local dappy = require('dap-python')
            -- print(vim.g["python3_host_prog"])
            dappy.setup(vim.g["python3_host_prog"])
            dappy.test_runner = 'pytest'
		end,
	},
}