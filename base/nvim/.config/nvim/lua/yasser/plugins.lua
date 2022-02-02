local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = fn.stdpath("config") .. "/lua/packer_compiled.lua"
local dap_types = {"python", "lua", "c", "cpp", "php", "java", "js"}
if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " ..
                install_path)
    execute "packadd packer.nvim"
end
-- Autocommand that reloads neovim whenever you save the plugins.lua file
function OnPluginRecompile()
    vim.cmd [[
	luafile %
	PackerCompile
	PackerClean
	PackerInstall
	]]
end

vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua lua OnPluginRecompile()
  augroup end
]]
-- helpers. taken from datwaft https://github.com/datwaft/nvim/blob/master/lua/plugins/init.lua
local windows = function()
    return vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 or
               vim.fn.has('win16') == 1
end

local tmux = function() return vim.fn.exists('$TMUX') == 1 end

-- local kitty = function() return vim.fn.exists('$KITTY_WINDOW_ID') == 1 end

return require("packer").startup({
    function(use)
        -- use_rocks {"inspect"}
        -- Packer can manage itself as an optional plugin
        --
        use "wbthomason/packer.nvim"

        -- grammer check
        use {
            'rhysd/vim-grammarous',
            opt = true,
            cmd = {'GrammarousCheck', 'GrammarousReset'}
        }

        -- CDing into the project root always
        use {'airblade/vim-rooter'}

        -- Telescope
        use {"nvim-lua/popup.nvim", opt = false}
        use {"nvim-lua/plenary.nvim", opt = false}
        use {"tjdevries/astronauta.nvim", opt = false}
        use {
            "nvim-telescope/telescope.nvim",
            opt = false,
            requires = {"nvim-lua/plenary.nvim"},
            config = function() require 'yasser.search.telescope' end
        }
        use {
            'nvim-telescope/telescope-symbols.nvim',
            opt = false,
            requires = {"nvim-telescope/telescope.nvim"}
        }
        use {
            'nvim-telescope/telescope-packer.nvim',
            opt = false,
            requires = {"nvim-telescope/telescope.nvim"},
            config = function()
                require("telescope").load_extension "packer"
            end
        }
        use {
            'nvim-telescope/telescope-fzy-native.nvim',
            opt = false,
            requires = {"nvim-telescope/telescope.nvim"},
            config = function()
                require('telescope').load_extension('fzy_native')
            end
        }
        -- use {
        --     "nvim-telescope/telescope-project.nvim",
        --     event = "BufRead",
        --     setup = function() vim.cmd [[packadd telescope.nvim]] end
        -- }
        -- auto vormatting
        use {
            'sbdchd/neoformat',
            opt = false,
            setup = function()
                vim.cmd([[ let g:neoformat_enabled_python = ['black'] ]])
            end
        }
        -- LSP
        use {
            "neovim/nvim-lspconfig",
            opt = false,
            config = function() require('yasser.lsp.config') end
        }
        -- fix lsp highlight
        use {"antoinemadec/FixCursorHold.nvim", opt = false}
        use {
            "tami5/lspsaga.nvim",
            opt = false,
            config = function() require('yasser.lsp.saga') end

        }
        use {
            "kabouzeid/nvim-lspinstall",
            opt = false,
            config = function() require("yasser.lsp.lspinstaller") end
        }
        use {'ray-x/lsp_signature.nvim', opt = true, ft = {"python"}}
        use {
            "williamboman/nvim-lsp-installer",
            opt = true,
            cmd = {
                "LspInstall", "LspUninstall", "LspInstallInfo",
                "LspUninstallAll", "LspPrintInstalled"
            },
            config = function() require("yasser.lsp.lspinstaller") end
        }

        -- Markdown
        use {'tpope/vim-markdown', opt = true, ft = 'markdown'}
        use {
            'iamcco/markdown-preview.nvim',
            opt = true,
            ft = 'markdown',
            run = 'cd app & yarn install'
        }

        -- Debugging
        use {"jbyuki/one-small-step-for-vimkind", opt = true, ft = {"lua"}}
        use {
            "mfussenegger/nvim-dap",
            opt = true,
            ft = dap_types,
            config = function() require "yasser.debug.dapcfg" end
        }
        use {
            "Pocco81/DAPInstall.nvim",
            opt = true,
            cmd = {"DIInstall", "DIUninstall", "DIList"},
            config = function() require "yasser.debug.dapinstall" end
        }

        use {
            "rcarriga/nvim-dap-ui",
            opt = true,
            ft = dap_types,
            -- requires = {{"mfussenegger/nvim-dap", opt=true}},
            -- after = {"mfussenegger/nvim-dap"},
            config = function() require('yasser.debug.dapui') end
        }
        use {
            'nvim-telescope/telescope-dap.nvim',
            opt = true,
            ft = dap_types,
            -- requires = {{"mfussenegger/nvim-dap", opt=true},{ "nvim-telescope/telescope.nvim", opt=true}},
            -- after = {"mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim"},
            config = function()
                require('telescope').load_extension('dap')
            end
        }
        use {
            'theHamsta/nvim-dap-virtual-text',
            opt = true,
            ft = dap_types,
            -- requires = {{"mfussenegger/nvim-dap", opt=true},{ "nvim-telescope/telescope.nvim", opt=true}},
            -- requires = {{"mfussenegger/nvim-dap", opt=true}},
            -- after = {"mfussenegger/nvim-dap"},
            config = function() vim.g.dap_virtual_text = true end
        }
        use {
            'mfussenegger/nvim-dap-python',
            opt = true,
            ft = {"python"},
            -- requires = "mfussenegger/nvim-dap",
            -- after = {"mfussenegger/nvim-dap"},
            config = function() require('yasser.debug.dappy') end
        }

        -- Testing
        use {'5long/pytest-vim-compiler', opt = true, ft = {"python"}}
        use {'janko/vim-test', opt = true, ft = {"python"}}
        -- use {'rcarriga/vim-ultest', opt = false, require = {'janko/vim-test'}}

        -- Python

        -- Lua
        use {'tjdevries/nlua.nvim', opt = true, ft = "lua"}

        -- SQL
        use {'nanotee/sqls.nvim', disable = windows(), opt = true, ft = {"sql"}}

        -- Autocomplete
        -- use {
        --     "hrsh7th/nvim-compe",
        --     opt = false,
        --     config = function() require('completion') end
        -- }
        use {'onsails/lspkind-nvim', opt = false}
        use {
            'hrsh7th/nvim-cmp',
            opt = false,
            requires = {
                "hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp",
                -- 'quangnguyen30192/cmp-nvim-ultisnips',
                "saadparwaiz1/cmp_luasnip", 'hrsh7th/cmp-nvim-lua',
                'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
                'f3fora/cmp-spell', 'hrsh7th/cmp-emoji'
            },
            config = function() require('yasser.completion.cmpconf') end
        }

        -- Snippets
        -- use {'SirVer/ultisnips', opt = false}
        -- use {'honza/vim-snippets', opt = false}
        -- use {"hrsh7th/vim-vsnip", opt = false}
        use "L3MON4D3/LuaSnip" -- snippet engine
        use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

        -- Treesitter
        use {
            "nvim-treesitter/nvim-treesitter",
            run = ":TSUpdate",
            config = function() require('yasser.theme.treesitter') end
        }
        use {
            'heavenshell/vim-pydocstring',
            run = "make install",
            opt = true,
            ft = {"python"},
            config = function()
                vim.cmd [[let g:pydocstring_formatter = 'google']]
            end
        }
        -- closes autotags using treesitter
        -- use {"windwp/nvim-ts-autotag", opt = false}
        use {
            "nvim-treesitter/playground",
            opt = false,
            config = function() require 'yasser.theme.playground' end
        }

        -- symbol preview
        use {'simrat39/symbols-outline.nvim', opt = false}

        -- Git
        use {
            "lewis6991/gitsigns.nvim",
            opt = false,
            config = function() require 'yasser.git.gitsigns' end
        }
        -- use {
        --     'sindrets/diffview.nvim',
        --     opt = false,
        --     config = function() require 'git.diffview' end
        -- }
        use {'tpope/vim-fugitive', opt = false}
        use {'tpope/vim-rhubarb', opt = false}

        -- Which key
        -- use {
        --     "liuchengxu/vim-which-key",
        --     opt = false,
        --     config = function()
        --         vim.cmd('source $HOME/.config/nvim/vimscript/whichkey.vim')
        --     end
        -- }
        -- performance (faster startup)
        use {'lewis6991/impatient.nvim', opt = false}
        -- Start screen
        -- use {
        --     "ChristianChiarulli/dashboard-nvim",
        --     opt = false,
        --     config = function() require 'theme.dashboard' end
        -- }
        use {
            "goolord/alpha-nvim",
            opt = false,
            config = function() require 'yasser.theme.alpha' end
        }

        use {
            "terrortylor/nvim-comment",
            opt = false,
            config = function() require('nvim_comment').setup() end
        }
        use {"JoosepAlviste/nvim-ts-context-commentstring", opt = false}
        -- use {"kevinhwang91/nvim-bqf", opt = false}

        -- Floating terminal (may be unnecesasry)
        use {'voldikss/vim-floaterm', opt = false}

        -- Tables
        use {'godlygeek/tabular', opt = false}
        use {'dhruvasagar/vim-table-mode', opt = false}

        -- basic navigation (tpope)
        use {'tpope/vim-surround', opt = false}
        use {'tpope/vim-unimpaired', opt = false}
        use {'tpope/vim-repeat', opt = false}
        use {'tpope/vim-dispatch', opt = false}
        use {'tpope/vim-abolish', opt = false}
        use {'tpope/vim-capslock', opt = false} -- <C-g>c for capslock
        use {'tpope/vim-eunuch', opt = false} -- Unix helpful commands like Move, SudoWrite

        -- -- kitty interaction
        -- -- use {'knubie/vim-kitty-navigator', opt = false}
        -- use {'knubie/vim-kitty-navigator', opt = false, cond = {kitty}}
        -- tumx integration
        use {
            'robaire/nvim-tmux-navigator',
            opt = true,
            cond = {tmux},
            setup = function() require 'yasser.nav.tmuxconf' end
        }

        -- Extra search and replace
        use {'dyng/ctrlsf.vim', opt = false}

        -- Show current context
        use {'wellle/context.vim', opt = false}

        -- search and replace in multipole files
        use {'brooth/far.vim', opt = false}

        -- Color
        use {"christianchiarulli/nvcode-color-schemes.vim", opt = false}
        use 'folke/tokyonight.nvim'

        -- Icons
        use {"kyazdani42/nvim-web-devicons", opt = false}

        -- Diagnostic and niceties
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function() require "yasser.debug.trouble" end
        }
        -- Colorize whitespace
        use {
            'ntpeters/vim-better-whitespace',
            opt = false,
            config = function()
                vim.g.better_whitespace_filetypes_blacklist =
                    {
                        'dashboard', 'ALPHA', 'diff', 'gitcommit', 'unite',
                        'nvimtree', 'qf', 'help', 'packer'
                    }
            end
        }

        -- Status Line and Bufferline
        -- use {
        --     "glepnir/galaxyline.nvim",
        --     opt = false,
        --     config = function() require 'yasser.theme.galaxyline' end
        -- }
        use {
            "nvim-lualine/lualine.nvim",
            opt = false,
            config = function() require "yasser.theme.lualine" end
        }
        use {"moll/vim-bbye", opt = false}
        -- use {
        --     "romgrk/barbar.nvim",
        --     opt = false,
        --     config = function() require 'yasser.theme.barbar' end
        -- }

        -- visual start search
        use {'nelstrom/vim-visual-star-search', opt = false}
        -- undo tree
        use {'mbbill/undotree', opt = false}

        -- text objects
        use {'kana/vim-textobj-user', opt = false}
        use {'rhysd/vim-textobj-anyblock', opt = false}
        use {'kana/vim-textobj-line', opt = false}
        use {'michaeljsmith/vim-indent-object', opt = false}
        use {
            'nvim-treesitter/nvim-treesitter-textobjects',
            opt = false,
            config = function()
                require "yasser.nav.treesitter_textobjects"
            end
        }

        -- tex
        use {'lervag/vimtex', opt = true, ft = {"tex", "bib"}}

        -- changes the highlghting of the current match
        use {'PeterRincker/vim-searchlight', opt = false}

        -- matching pairs
        use {'tmhedberg/matchit', opt = false}

        -- add closing parentheses automatically.
        -- use {'jiangmiao/auto-pairs', opt = false}
        use {
            "windwp/nvim-autopairs",
            opt = false,
            config = function()
                require("yasser.completion.autopairs")
            end
        }
        -- use {'Raimondi/delimitMate', opt = false}
        -- use {
        --     "steelsojka/pears.nvim",
        --     opt = false,
        --     config = function()
        --         local pears = require "pears"
        --         pears.setup(function(conf)
        --             conf.on_enter(function(pears_handle)
        --                 if vim.fn.pumvisible() == 1 and
        --                     vim.fn.complete_info().selected ~= -1 then
        --                     return vim.fn["cmp#confirm"]("<CR>")
        --                 else
        --                     pears_handle()
        --                 end
        --             end)
        --         end)
        --     end
        -- }

        -- closes html tags
        use {'alvan/vim-closetag', opt = true, ft = {"html", "xml", "php"}}

        -- maps <leader>[, <leader>] to move to top and bottom of indent
        use {'tmhedberg/indent-motion', opt = false}

        -- zooms windows out and in using <c-w>m
        use {'dhruvasagar/vim-zoom', opt = false}

        -- Vim in browser

        -- use {'subnut/nvim-ghost.nvim', run = function() vim.fn['nvim_ghost#installer#install()']() end}
        -- use {
        --     "glacambre/firenvim",
        --     run = function()
        --         vim.fn['firenvim#install'](0)
        --     end
        -- }

        -- show indent lines
        use {
            'lukas-reineke/indent-blankline.nvim',
            config = function()
                require 'yasser.theme.indent-blankline'
            end,
            disable = windows()
        }

        -- Which Key
        use {
            "folke/which-key.nvim",
            config = function() require 'yasser.whichkeymap' end
        }

        -- Explorer
        use {
            "kyazdani42/nvim-tree.lua",
            opt = false,
            config = function() require 'yasser.nav.nvimtree' end
        }

        -- notebook-like environment
        use {"benmills/vimux", opt = true, ft = {"python"}}
        use {"julienr/vim-cellmode", opt = true, ft = {"python"}}
        use {"greghor/vim-pyShell", opt = true, ft = "python"}

        -- transparent background
        use {
            "xiyaowong/nvim-transparent",
            opt = false,
            config = function() require "yasser.theme.transparent" end
        }
    end,
    config = {
        ensure_dependencies = true,
        compile_on_sync = true,
        compile_path = compile_path
    }
})
