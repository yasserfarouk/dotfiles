local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local compile_path = fn.stdpath("config") .. "/plugin/packer_compiled.vim"

if fn.empty(fn.glob(install_path)) > 0 then
    execute("!git clone https://github.com/wbthomason/packer.nvim " ..
                install_path)
    execute "packadd packer.nvim"
end

-- helpers. taken from datwaft https://github.com/datwaft/nvim/blob/master/lua/plugins/init.lua
local windows = function()
    return vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 or
               vim.fn.has('win16') == 1
end

local tmux = function() return vim.fn.exists('$TMUX') == 1 end

local kitty = function() return vim.fn.exists('$KITTY_WINDOW_ID') == 1 end

vim.cmd "autocmd BufWritePost plugins.lua PackerCompile" -- Auto compile when there are changes in plugins.lua

return require("packer").startup({
    function(use)
        -- Packer can manage itself as an optional plugin
        use "wbthomason/packer.nvim"

        -- grammer check
        use {'rhysd/vim-grammarous', opt = false}

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
            config = function() require 'search.telescope' end
        }
        use {
            'nvim-telescope/telescope-symbols.nvim',
            opt = false,
            requires = {"nvim-telescope/telescope.nvim"}
        }
        use {
            'nvim-telescope/telescope-fzy-native.nvim',
            opt = false,
            requires = {"nvim-telescope/telescope.nvim"},
            config = function()
                require('telescope').load_extension('fzy_native')
            end
        }
        use {
            "nvim-telescope/telescope-project.nvim",
            event = "BufRead",
            setup = function() vim.cmd [[packadd telescope.nvim]] end
        }
        -- auto vormatting
        use {
            'sbdchd/neoformat',
            opt = false,
            setup = function()
                vim.cmd([[ let g:neoformat_enabled_python = ['black'] ]])
            end
        }
        -- LSP
        use {"neovim/nvim-lspconfig", opt = false}
        use {"glepnir/lspsaga.nvim", opt = false}
        use {"kabouzeid/nvim-lspinstall", opt = false}
        use {'ray-x/lsp_signature.nvim', opt = false}

        -- Markdown
        use {'tpope/vim-markdown', opt = false, ft = 'markdown'}
        use {
            'iamcco/markdown-preview.nvim',
            opt = false,
            ft = 'markdown',
            run = 'cd app & yarn install'
        }

        -- Debugging
        use {
            "mfussenegger/nvim-dap",
            opt = false,
            -- ft = {"python", "lua"},
            config = function()
                vim.fn.sign_define('DapBreakpoint', {
                    text = "🔸",
                    texthl = "",
                    linehl = "",
                    numhl = ""
                })
                vim.fn.sign_define('DapBreakpointRejected', {
                    text = "💀",
                    texthl = "",
                    linehl = "",
                    numhl = ""
                })
                vim.fn.sign_define('DapLogPoint', {
                    text = "📚",
                    texthl = "",
                    linehl = "",
                    numhl = ""
                })
                vim.cmd([[
				nnoremap <silent> <F3> :DebugScopes<CR>
				nnoremap <silent> <F4> :DebugHover<CR>
				nnoremap <silent> <S-F4> :DebugVHover<CR>
				nnoremap <silent> <F5> :DebugContinue<CR>
				nnoremap <silent> <S-F5> :DebugLast<CR>
				nnoremap <silent> <C-F5> :DebugPause<CR>
				nnoremap <silent> <F6> :DebugToggleRepl<CR>
				nnoremap <silent> <F7> :DebugUp<CR>
				nnoremap <silent> <F8> :DebugDown<CR>
				nnoremap <silent> <A-F8> :DebugSetExceptionBreakpointsDefault<CR>
				nnoremap <silent> <S-F8> :DebugSetExceptionBreakpointsRaised<CR>
				nnoremap <silent> <C-F8> :DebugSetExceptionBreakpointsUncaught<CR>
				nnoremap <silent> <F9> :DebugToggleBreakpoint<CR>
				nnoremap <silent> <A-F9> :DebugLogPoint<CR>
				nnoremap <silent> <S-F9> :DebugConditionalBreakpoint<CR>
				nnoremap <silent> <C-F9> :DebugListBreakpoints<CR>
				nnoremap <silent> <F10> :DebugStepOver<CR>
				nnoremap <silent> <F11> :DebugStepInto<CR>
				nnoremap <silent> <S-F11> :DebugStepOut<CR>
				nnoremap <silent> <F12> :DebugStop<CR>
				]])
            end
        }
        use {
            "Pocco81/DAPInstall.nvim",
            opt = false,
            config = function()

                local dap_install = require("dap-install")
                local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()

                for debugger, _ in pairs(dbg_list) do
					dap_install.config(debugger)
                end
            end
        }

        -- use {
        --     "rcarriga/nvim-dap-ui",
        --     opt = true,
        --     ft = {"python", "lua"},
        --     requires = {"mfussenegger/nvim-dap"},
        --     after = {"nvim-dap"},
        --     config = function()
        --         require('debug.dapui')
        --     end
        -- }
        use {
            'nvim-telescope/telescope-dap.nvim',
            opt = true,
            ft = {"python", "lua"},
            requires = "mfussenegger/nvim-dap",
            -- after = {"mfussenegger/nvim-dap"},
            config = function()
                require('telescope').load_extension('dap')
            end
        }
        use {
            'theHamsta/nvim-dap-virtual-text',
            opt = true,
            ft = {"python", "lua"},
            requires = "mfussenegger/nvim-dap",
            -- after = {"mfussenegger/nvim-dap"},
            config = function() vim.g.dap_virtual_text = true end
        }
        -- use {
        --     'mfussenegger/nvim-dap-python',
        --     opt = true,
        --     ft = {"python"},
        --     requires = "mfussenegger/nvim-dap",
        --     -- after = {"mfussenegger/nvim-dap"},
        --     config = function()
        --         local dap = require('nvim-dap')
        --         require('debug.dap-py')
        --     end
        -- }

        -- Testing
        use {'5long/pytest-vim-compiler', opt = false}
        use {'janko/vim-test', opt = false}
        -- use {'rcarriga/vim-ultest', opt = false, require = {'janko/vim-test'}}

        -- Python

        -- Lua
        use {'tjdevries/nlua.nvim', opt = false, ft = "lua"}

        -- SQL
        use {'nanotee/sqls.nvim', disable = windows()}

        -- Autocomplete
        use {
            "hrsh7th/nvim-compe",
            opt = false,
            config = function() require('completion') end
        }

        -- Snippets
        use {"hrsh7th/vim-vsnip", opt = false}
        -- use {'SirVer/ultisnips', opt = false}
        use {'honza/vim-snippets', opt = false}

        -- Treesitter
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        -- closes autotags using treesitter
        -- use {"windwp/nvim-ts-autotag", opt = false}
        use {
            "nvim-treesitter/playground",
            opt = false,
            config = function() require 'theme.playground' end
        }

        -- symbol preview
        use {'simrat39/symbols-outline.nvim', opt = false}

        -- Git
        use {
            "lewis6991/gitsigns.nvim",
            opt = false,
            config = function() require 'git.gitsigns' end
        }
        use {
            'sindrets/diffview.nvim',
            opt = false,
            config = function() require 'git.diffview' end
        }
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

        -- Start screen
        use {
            "ChristianChiarulli/dashboard-nvim",
            opt = false,
            config = function() require 'theme.dashboard' end
        }

        use {
            "terrortylor/nvim-comment",
            opt = false,
            config = function() require('nvim_comment').setup() end
        }
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

        -- kitty interaction
        -- use {'knubie/vim-kitty-navigator', opt = false}
        use {'knubie/vim-kitty-navigator', opt = false, cond = {kitty}}
        -- tumx integration
        use {
            'christoomey/vim-tmux-navigator',
            opt = false,
            cond = {tmux},
            setup = function() require 'nav.tmux' end
        }

        -- Extra search and replace
        use {'dyng/ctrlsf.vim', opt = false}

        -- Show current context
        use {'wellle/context.vim', opt = true}

        -- search and replace in multipole files
        use {'brooth/far.vim', opt = false}

        -- Color
        use {"christianchiarulli/nvcode-color-schemes.vim", opt = false}
        use 'folke/tokyonight.nvim'

        -- Icons
        -- use {"kyazdani42/nvim-web-devicons", opt = false}

        -- Diagnostic and niceties
        use {
            "folke/trouble.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("trouble").setup {}
                vim.api.nvim_set_keymap("n", "<leader>ix", "<cmd>Trouble<cr>",
                                        {silent = true, noremap = true})
                vim.api.nvim_set_keymap("n", "<leader>iw",
                                        "<cmd>Trouble lsp_workspace_diagnostics<cr>",
                                        {silent = true, noremap = true})
                vim.api.nvim_set_keymap("n", "<leader>id",
                                        "<cmd>Trouble lsp_document_diagnostics<cr>",
                                        {silent = true, noremap = true})
                vim.api.nvim_set_keymap("n", "<leader>il",
                                        "<cmd>Trouble loclist<cr>",
                                        {silent = true, noremap = true})
                vim.api.nvim_set_keymap("n", "<leader>iq",
                                        "<cmd>Trouble quickfix<cr>",
                                        {silent = true, noremap = true})
                vim.api.nvim_set_keymap("n", "gR",
                                        "<cmd>Trouble lsp_references<cr>",
                                        {silent = true, noremap = true})
            end
        }
        -- Colorize whitespace
        use {
            'ntpeters/vim-better-whitespace',
            opt = false,
            config = function()
                vim.g.better_whitespace_filetypes_blacklist =
                    {
                        'dashboard', 'diff', 'gitcommit', 'unite', 'nvimtree',
                        'qf', 'help', 'packer'
                    }
            end
        }

        -- Status Line and Bufferline
        use {
            "glepnir/galaxyline.nvim",
            opt = false,
            config = function() require 'theme.galaxyline' end
        }
        use {
            "romgrk/barbar.nvim",
            opt = false,
            config = function() require 'theme.barbar' end
        }

        -- visual start search
        use {'nelstrom/vim-visual-star-search', opt = false}
        -- undo tree
        use {'mbbill/undotree', opt = false}

        -- text objects
        use {'kana/vim-textobj-user', opt = false}
        use {'rhysd/vim-textobj-anyblock', opt = false}
        use {'kana/vim-textobj-line', opt = false}
        use {'michaeljsmith/vim-indent-object', opt = false}

        -- tex
        use {'lervag/vimtex', opt = true, ft = {"tex", "bib"}}

        -- changes the highlghting of the current match
        use {'PeterRincker/vim-searchlight', opt = false}

        -- matching pairs
        use {'tmhedberg/matchit', opt = false}

        -- add closing parentheses automatically.
        use {'jiangmiao/auto-pairs', opt = false}
        -- use {"windwp/nvim-autopairs", opt = false}
        -- use {'Raimondi/delimitMate', opt = false}

        -- closes html tags
        use {'alvan/vim-closetag', opt = false}

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
            config = function() require 'theme.indent-blankline' end,
            disable = windows()
        }

        -- Which Key
        use {
            "folke/which-key.nvim",
            config = function() require 'whichkeymap' end
        }

        -- Explorer
        use {
            "kyazdani42/nvim-tree.lua",
            opt = false,
            config = function() require 'nav.nvimtree' end
        }
    end,
    config = {
        ensure_dependencies = true,
        compile_on_sync = true,
        compile_path = compile_path
    }
})
