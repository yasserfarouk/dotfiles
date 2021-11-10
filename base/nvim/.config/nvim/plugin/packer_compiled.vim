" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/Users/yasser/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/Users/yasser/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/Users/yasser/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/Users/yasser/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/Users/yasser/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["astronauta.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/astronauta.nvim",
    url = "https://github.com/tjdevries/astronauta.nvim"
  },
  ["barbar.nvim"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17theme.barbar\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/barbar.nvim",
    url = "https://github.com/romgrk/barbar.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-calc"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/cmp-calc",
    url = "https://github.com/hrsh7th/cmp-calc"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/cmp-emoji",
    url = "https://github.com/hrsh7th/cmp-emoji"
  },
  ["cmp-look"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/cmp-look",
    url = "https://github.com/octaltree/cmp-look"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-nvim-ultisnips"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/cmp-nvim-ultisnips",
    url = "https://github.com/quangnguyen30192/cmp-nvim-ultisnips"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-spell"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/cmp-spell",
    url = "https://github.com/f3fora/cmp-spell"
  },
  ["context.vim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/context.vim",
    url = "https://github.com/wellle/context.vim"
  },
  ["ctrlsf.vim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/ctrlsf.vim",
    url = "https://github.com/dyng/ctrlsf.vim"
  },
  ["dashboard-nvim"] = {
    config = { "\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20theme.dashboard\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/dashboard-nvim",
    url = "https://github.com/ChristianChiarulli/dashboard-nvim"
  },
  ["far.vim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/far.vim",
    url = "https://github.com/brooth/far.vim"
  },
  ["galaxyline.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21theme.galaxyline\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/galaxyline.nvim",
    url = "https://github.com/glepnir/galaxyline.nvim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17git.gitsigns\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27theme.indent-blankline\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["indent-motion"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/indent-motion",
    url = "https://github.com/tmhedberg/indent-motion"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\nZ\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0;\t\t\t\t\tnnoremap <silent> gh :Lspsaga lsp_finder<CR>\n\t\t\t\t\bcmd\bvim\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  matchit = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/matchit",
    url = "https://github.com/tmhedberg/matchit"
  },
  neoformat = {
    loaded = true,
    needs_bufread = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/neoformat",
    url = "https://github.com/sbdchd/neoformat"
  },
  ["nlua.nvim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/nlua.nvim",
    url = "https://github.com/tjdevries/nlua.nvim"
  },
  ["nvcode-color-schemes.vim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvcode-color-schemes.vim",
    url = "https://github.com/christianchiarulli/nvcode-color-schemes.vim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15completion\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-comment"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17nvim_comment\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-comment",
    url = "https://github.com/terrortylor/nvim-comment"
  },
  ["nvim-dap"] = {
    config = { "\27LJ\2\nè\n\0\0\4\0\v\0\0236\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0005\3\6\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0005\3\b\0B\0\3\0016\0\0\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0¸\a\t\t\t\tnnoremap <silent> <F3> :DebugScopes<CR>\n\t\t\t\tnnoremap <silent> <F4> :DebugHover<CR>\n\t\t\t\tnnoremap <silent> <S-F4> :DebugVHover<CR>\n\t\t\t\tnnoremap <silent> <F5> :DebugContinue<CR>\n\t\t\t\tnnoremap <silent> <S-F5> :DebugLast<CR>\n\t\t\t\tnnoremap <silent> <C-F5> :DebugPause<CR>\n\t\t\t\tnnoremap <silent> <F6> :DebugToggleRepl<CR>\n\t\t\t\tnnoremap <silent> <F7> :DebugUp<CR>\n\t\t\t\tnnoremap <silent> <F8> :DebugDown<CR>\n\t\t\t\tnnoremap <silent> <A-F8> :DebugSetExceptionBreakpointsDefault<CR>\n\t\t\t\tnnoremap <silent> <S-F8> :DebugSetExceptionBreakpointsRaised<CR>\n\t\t\t\tnnoremap <silent> <C-F8> :DebugSetExceptionBreakpointsUncaught<CR>\n\t\t\t\tnnoremap <silent> <F9> :DebugToggleBreakpoint<CR>\n\t\t\t\tnnoremap <silent> <A-F9> :DebugLogPoint<CR>\n\t\t\t\tnnoremap <silent> <S-F9> :DebugConditionalBreakpoint<CR>\n\t\t\t\tnnoremap <silent> <C-F9> :DebugListBreakpoints<CR>\n\t\t\t\tnnoremap <silent> <F10> :DebugStepOver<CR>\n\t\t\t\tnnoremap <silent> <F11> :DebugStepInto<CR>\n\t\t\t\tnnoremap <silent> <S-F11> :DebugStepOut<CR>\n\t\t\t\tnnoremap <silent> <F12> :DebugStop<CR>\n\t\t\t\t\bcmd\1\0\4\ttext\tüìö\vlinehl\5\vtexthl\5\nnumhl\5\16DapLogPoint\1\0\4\ttext\tüíÄ\vlinehl\5\vtexthl\5\nnumhl\5\26DapBreakpointRejected\1\0\4\ttext\tüî∏\vlinehl\5\vtexthl\5\nnumhl\5\18DapBreakpoint\16sign_define\afn\bvim\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-virtual-text"] = {
    config = { "\27LJ\2\n2\0\0\2\0\3\0\0056\0\0\0009\0\1\0+\1\2\0=\1\2\0K\0\1\0\21dap_virtual_text\6g\bvim\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-lspinstall"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-lspinstall",
    url = "https://github.com/kabouzeid/nvim-lspinstall"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17nav.nvimtree\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["pears.nvim"] = {
    config = { "\27LJ\2\nü\1\0\1\4\0\a\2\0226\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\rÄ6\1\0\0009\1\1\0019\1\3\1B\1\1\0029\1\4\1\b\1\1\0X\1\6Ä6\1\0\0009\1\1\0019\1\5\1'\3\6\0D\1\2\0X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\t<CR>\16cmp#confirm\rselected\18complete_info\15pumvisible\afn\bvim\2˛ˇˇˇ\31!\1\1\4\0\2\0\0049\1\0\0003\3\1\0B\1\2\1K\0\1\0\0\ron_enter8\1\0\4\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0003\3\3\0B\1\2\1K\0\1\0\0\nsetup\npears\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/pears.nvim",
    url = "https://github.com/steelsojka/pears.nvim"
  },
  playground = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21theme.playground\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["pytest-vim-compiler"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/pytest-vim-compiler",
    url = "https://github.com/5long/pytest-vim-compiler"
  },
  ["sqls.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/sqls.nvim",
    url = "https://github.com/nanotee/sqls.nvim"
  },
  ["symbols-outline.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  tabular = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/tabular",
    url = "https://github.com/godlygeek/tabular"
  },
  ["telescope-dap.nvim"] = {
    config = { "\27LJ\2\nH\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\bdap\19load_extension\14telescope\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/telescope-dap.nvim",
    url = "https://github.com/nvim-telescope/telescope-dap.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\15fzy_native\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim",
    url = "https://github.com/nvim-telescope/telescope-symbols.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21search.telescope\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n˛\4\0\0\6\0\25\00076\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\r\0'\4\14\0005\5\15\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\16\0'\4\17\0005\5\18\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\19\0'\4\20\0005\5\21\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\22\0'\4\23\0005\5\24\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2$<cmd>Trouble lsp_references<cr>\agR\1\0\2\vsilent\2\fnoremap\2\30<cmd>Trouble quickfix<cr>\15<leader>iq\1\0\2\vsilent\2\fnoremap\2\29<cmd>Trouble loclist<cr>\15<leader>il\1\0\2\vsilent\2\fnoremap\2.<cmd>Trouble lsp_document_diagnostics<cr>\15<leader>id\1\0\2\vsilent\2\fnoremap\2/<cmd>Trouble lsp_workspace_diagnostics<cr>\15<leader>iw\1\0\2\vsilent\2\fnoremap\2\21<cmd>Trouble<cr>\15<leader>ix\6n\20nvim_set_keymap\bapi\bvim\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ultisnips = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/ultisnips",
    url = "https://github.com/SirVer/ultisnips"
  },
  undotree = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-abolish"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-abolish",
    url = "https://github.com/tpope/vim-abolish"
  },
  ["vim-better-whitespace"] = {
    config = { "\27LJ\2\nÇ\1\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\t\0\0\14dashboard\tdiff\14gitcommit\nunite\rnvimtree\aqf\thelp\vpacker*better_whitespace_filetypes_blacklist\6g\bvim\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-better-whitespace",
    url = "https://github.com/ntpeters/vim-better-whitespace"
  },
  ["vim-capslock"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-capslock",
    url = "https://github.com/tpope/vim-capslock"
  },
  ["vim-closetag"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-closetag",
    url = "https://github.com/alvan/vim-closetag"
  },
  ["vim-dispatch"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-dispatch",
    url = "https://github.com/tpope/vim-dispatch"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-floaterm"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-floaterm",
    url = "https://github.com/voldikss/vim-floaterm"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-grammarous"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-grammarous",
    url = "https://github.com/rhysd/vim-grammarous"
  },
  ["vim-indent-object"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-indent-object",
    url = "https://github.com/michaeljsmith/vim-indent-object"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/vim-markdown",
    url = "https://github.com/tpope/vim-markdown"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-repeat",
    url = "https://github.com/tpope/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-rooter",
    url = "https://github.com/airblade/vim-rooter"
  },
  ["vim-searchlight"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-searchlight",
    url = "https://github.com/PeterRincker/vim-searchlight"
  },
  ["vim-snippets"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-snippets",
    url = "https://github.com/honza/vim-snippets"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-table-mode"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-table-mode",
    url = "https://github.com/dhruvasagar/vim-table-mode"
  },
  ["vim-test"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-test",
    url = "https://github.com/janko/vim-test"
  },
  ["vim-textobj-anyblock"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-textobj-anyblock",
    url = "https://github.com/rhysd/vim-textobj-anyblock"
  },
  ["vim-textobj-line"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-textobj-line",
    url = "https://github.com/kana/vim-textobj-line"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["vim-tmux-navigator"] = {
    cond = { "\27LJ\2\nH\0\0\3\0\4\1\v6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\b\0\0\0X\0\2Ä+\0\1\0X\1\1Ä+\0\2\0L\0\2\0\n$TMUX\vexists\afn\bvim\2\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/vim-tmux-navigator",
    url = "https://github.com/christoomey/vim-tmux-navigator"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
  },
  ["vim-visual-star-search"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-visual-star-search",
    url = "https://github.com/nelstrom/vim-visual-star-search"
  },
  ["vim-zoom"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-zoom",
    url = "https://github.com/dhruvasagar/vim-zoom"
  },
  vimtex = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/vimtex",
    url = "https://github.com/lervag/vimtex"
  },
  ["which-key.nvim"] = {
    config = { "\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16whichkeymap\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Setup for: neoformat
time([[Setup for neoformat]], true)
try_loadstring("\27LJ\2\nP\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0001 let g:neoformat_enabled_python = ['black'] \bcmd\bvim\0", "setup", "neoformat")
time([[Setup for neoformat]], false)
time([[packadd for neoformat]], true)
vim.cmd [[packadd neoformat]]
time([[packadd for neoformat]], false)
-- Setup for: vim-tmux-navigator
time([[Setup for vim-tmux-navigator]], true)
try_loadstring("\27LJ\2\n(\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\rnav.tmux\frequire\0", "setup", "vim-tmux-navigator")
time([[Setup for vim-tmux-navigator]], false)
-- Config for: vim-better-whitespace
time([[Config for vim-better-whitespace]], true)
try_loadstring("\27LJ\2\nÇ\1\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\t\0\0\14dashboard\tdiff\14gitcommit\nunite\rnvimtree\aqf\thelp\vpacker*better_whitespace_filetypes_blacklist\6g\bvim\0", "config", "vim-better-whitespace")
time([[Config for vim-better-whitespace]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17nav.nvimtree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: telescope-fzy-native.nvim
time([[Config for telescope-fzy-native.nvim]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\15fzy_native\19load_extension\14telescope\frequire\0", "config", "telescope-fzy-native.nvim")
time([[Config for telescope-fzy-native.nvim]], false)
-- Config for: pears.nvim
time([[Config for pears.nvim]], true)
try_loadstring("\27LJ\2\nü\1\0\1\4\0\a\2\0226\1\0\0009\1\1\0019\1\2\1B\1\1\2\t\1\0\0X\1\rÄ6\1\0\0009\1\1\0019\1\3\1B\1\1\0029\1\4\1\b\1\1\0X\1\6Ä6\1\0\0009\1\1\0019\1\5\1'\3\6\0D\1\2\0X\1\2Ä\18\1\0\0B\1\1\1K\0\1\0\t<CR>\16cmp#confirm\rselected\18complete_info\15pumvisible\afn\bvim\2˛ˇˇˇ\31!\1\1\4\0\2\0\0049\1\0\0003\3\1\0B\1\2\1K\0\1\0\0\ron_enter8\1\0\4\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\1\2\0003\3\3\0B\1\2\1K\0\1\0\0\nsetup\npears\frequire\0", "config", "pears.nvim")
time([[Config for pears.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n*\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\15completion\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21search.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: barbar.nvim
time([[Config for barbar.nvim]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17theme.barbar\frequire\0", "config", "barbar.nvim")
time([[Config for barbar.nvim]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\nZ\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0;\t\t\t\t\tnnoremap <silent> gh :Lspsaga lsp_finder<CR>\n\t\t\t\t\bcmd\bvim\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: nvim-comment
time([[Config for nvim-comment]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17nvim_comment\frequire\0", "config", "nvim-comment")
time([[Config for nvim-comment]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n+\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\16whichkeymap\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: dashboard-nvim
time([[Config for dashboard-nvim]], true)
try_loadstring("\27LJ\2\n/\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\20theme.dashboard\frequire\0", "config", "dashboard-nvim")
time([[Config for dashboard-nvim]], false)
-- Config for: nvim-dap
time([[Config for nvim-dap]], true)
try_loadstring("\27LJ\2\nè\n\0\0\4\0\v\0\0236\0\0\0009\0\1\0009\0\2\0'\2\3\0005\3\4\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\5\0005\3\6\0B\0\3\0016\0\0\0009\0\1\0009\0\2\0'\2\a\0005\3\b\0B\0\3\0016\0\0\0009\0\t\0'\2\n\0B\0\2\1K\0\1\0¸\a\t\t\t\tnnoremap <silent> <F3> :DebugScopes<CR>\n\t\t\t\tnnoremap <silent> <F4> :DebugHover<CR>\n\t\t\t\tnnoremap <silent> <S-F4> :DebugVHover<CR>\n\t\t\t\tnnoremap <silent> <F5> :DebugContinue<CR>\n\t\t\t\tnnoremap <silent> <S-F5> :DebugLast<CR>\n\t\t\t\tnnoremap <silent> <C-F5> :DebugPause<CR>\n\t\t\t\tnnoremap <silent> <F6> :DebugToggleRepl<CR>\n\t\t\t\tnnoremap <silent> <F7> :DebugUp<CR>\n\t\t\t\tnnoremap <silent> <F8> :DebugDown<CR>\n\t\t\t\tnnoremap <silent> <A-F8> :DebugSetExceptionBreakpointsDefault<CR>\n\t\t\t\tnnoremap <silent> <S-F8> :DebugSetExceptionBreakpointsRaised<CR>\n\t\t\t\tnnoremap <silent> <C-F8> :DebugSetExceptionBreakpointsUncaught<CR>\n\t\t\t\tnnoremap <silent> <F9> :DebugToggleBreakpoint<CR>\n\t\t\t\tnnoremap <silent> <A-F9> :DebugLogPoint<CR>\n\t\t\t\tnnoremap <silent> <S-F9> :DebugConditionalBreakpoint<CR>\n\t\t\t\tnnoremap <silent> <C-F9> :DebugListBreakpoints<CR>\n\t\t\t\tnnoremap <silent> <F10> :DebugStepOver<CR>\n\t\t\t\tnnoremap <silent> <F11> :DebugStepInto<CR>\n\t\t\t\tnnoremap <silent> <S-F11> :DebugStepOut<CR>\n\t\t\t\tnnoremap <silent> <F12> :DebugStop<CR>\n\t\t\t\t\bcmd\1\0\4\ttext\tüìö\vlinehl\5\vtexthl\5\nnumhl\5\16DapLogPoint\1\0\4\ttext\tüíÄ\vlinehl\5\vtexthl\5\nnumhl\5\26DapBreakpointRejected\1\0\4\ttext\tüî∏\vlinehl\5\vtexthl\5\nnumhl\5\18DapBreakpoint\16sign_define\afn\bvim\0", "config", "nvim-dap")
time([[Config for nvim-dap]], false)
-- Config for: playground
time([[Config for playground]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21theme.playground\frequire\0", "config", "playground")
time([[Config for playground]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27theme.indent-blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n˛\4\0\0\6\0\25\00076\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\a\0'\4\b\0005\5\t\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\n\0'\4\v\0005\5\f\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\r\0'\4\14\0005\5\15\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\16\0'\4\17\0005\5\18\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\19\0'\4\20\0005\5\21\0B\0\5\0016\0\3\0009\0\4\0009\0\5\0'\2\6\0'\3\22\0'\4\23\0005\5\24\0B\0\5\1K\0\1\0\1\0\2\vsilent\2\fnoremap\2$<cmd>Trouble lsp_references<cr>\agR\1\0\2\vsilent\2\fnoremap\2\30<cmd>Trouble quickfix<cr>\15<leader>iq\1\0\2\vsilent\2\fnoremap\2\29<cmd>Trouble loclist<cr>\15<leader>il\1\0\2\vsilent\2\fnoremap\2.<cmd>Trouble lsp_document_diagnostics<cr>\15<leader>id\1\0\2\vsilent\2\fnoremap\2/<cmd>Trouble lsp_workspace_diagnostics<cr>\15<leader>iw\1\0\2\vsilent\2\fnoremap\2\21<cmd>Trouble<cr>\15<leader>ix\6n\20nvim_set_keymap\bapi\bvim\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: galaxyline.nvim
time([[Config for galaxyline.nvim]], true)
try_loadstring("\27LJ\2\n0\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\21theme.galaxyline\frequire\0", "config", "galaxyline.nvim")
time([[Config for galaxyline.nvim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n,\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\17git.gitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Conditional loads
time([[Conditional loading of vim-tmux-navigator]], true)
  require("packer.load")({"vim-tmux-navigator"}, {}, _G.packer_plugins)
time([[Conditional loading of vim-tmux-navigator]], false)
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType lua ++once lua require("packer.load")({'nvim-dap-virtual-text', 'nlua.nvim', 'telescope-dap.nvim'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType bib ++once lua require("packer.load")({'vimtex'}, { ft = "bib" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown', 'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'nvim-dap-virtual-text', 'telescope-dap.nvim'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType tex ++once lua require("packer.load")({'vimtex'}, { ft = "tex" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
time([[Sourcing ftdetect script at: /Users/yasser/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], true)
vim.cmd [[source /Users/yasser/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
time([[Sourcing ftdetect script at: /Users/yasser/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]], false)
time([[Sourcing ftdetect script at: /Users/yasser/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], true)
vim.cmd [[source /Users/yasser/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]]
time([[Sourcing ftdetect script at: /Users/yasser/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/cls.vim]], false)
time([[Sourcing ftdetect script at: /Users/yasser/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], true)
vim.cmd [[source /Users/yasser/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]]
time([[Sourcing ftdetect script at: /Users/yasser/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tex.vim]], false)
time([[Sourcing ftdetect script at: /Users/yasser/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], true)
vim.cmd [[source /Users/yasser/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]]
time([[Sourcing ftdetect script at: /Users/yasser/.local/share/nvim/site/pack/packer/opt/vimtex/ftdetect/tikz.vim]], false)
vim.cmd("augroup END")
if should_profile then save_profiles() end

END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
