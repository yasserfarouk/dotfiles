-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

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
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
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
  ["DAPInstall.nvim"] = {
    commands = { "DIInstall", "DIUninstall", "DIList" },
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28yasser.debug.dapinstall\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/DAPInstall.nvim",
    url = "https://github.com/Pocco81/DAPInstall.nvim"
  },
  LuaSnip = {
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30yasser.completion.luasnip\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23yasser.theme.alpha\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["bufferline.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28yasser.theme.bufferline\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/bufferline.nvim",
    url = "https://github.com/akinsho/bufferline.nvim"
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
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/cmp-emoji",
    url = "https://github.com/hrsh7th/cmp-emoji"
  },
  ["cmp-git"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/cmp-git",
    url = "https://github.com/petertriho/cmp-git"
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
  cmp_luasnip = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["code_runner.nvim"] = {
    config = { "\27LJ\2\nò\1\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\2B\0\2\1K\0\1\0\rfiletype\1\0\0\1\0\4\vpython\15python3 -u\15typescript\rdeno run\trust;cd $dir && rustc $fileName && $dir/$fileNameWithoutExt\tjava;cd $dir && javac $fileName && java $fileNameWithoutExt\nsetup\16code_runner\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/code_runner.nvim",
    url = "https://github.com/CRAG666/code_runner.nvim"
  },
  ["ctrlsf.vim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/ctrlsf.vim",
    url = "https://github.com/dyng/ctrlsf.vim"
  },
  ["dressing.nvim"] = {
    config = { "\27LJ\2\nš\1\0\0\5\0\n\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\4\0005\3\3\0=\3\5\0025\3\a\0005\4\6\0=\4\b\3=\3\t\2B\0\2\1K\0\1\0\vselect\fbackend\1\0\0\1\4\0\0\14telescope\bfzf\fbuiltin\ninput\1\0\0\1\0\1\rrelative\veditor\nsetup\rdressing\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/dressing.nvim",
    url = "https://github.com/stevearc/dressing.nvim"
  },
  ["far.vim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/far.vim",
    url = "https://github.com/brooth/far.vim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  ["fzf-lua"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25yasser.search.fzflua\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/fzf-lua",
    url = "https://github.com/ibhagwan/fzf-lua"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24yasser.git.gitsigns\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-blankline.nvim"] = {
    config = { "\27LJ\2\n=\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\"yasser.theme.indent-blankline\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/indent-blankline.nvim",
    url = "https://github.com/lukas-reineke/indent-blankline.nvim"
  },
  ["indent-motion"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/indent-motion",
    url = "https://github.com/tmhedberg/indent-motion"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25yasser.theme.lualine\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["mason-lspconfig.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/mason-lspconfig.nvim",
    url = "https://github.com/williamboman/mason-lspconfig.nvim"
  },
  ["mason.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/mason.nvim",
    url = "https://github.com/williamboman/mason.nvim"
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
  neogen = {
    commands = { "Neogen" },
    config = { "\27LJ\2\n1\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\22yasser.lsp.neogen\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/neogen",
    url = "https://github.com/danymat/neogen"
  },
  ["nlua.nvim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/nlua.nvim",
    url = "https://github.com/tjdevries/nlua.nvim"
  },
  ["null-ls.nvim"] = {
    config = { "\27LJ\2\nà\1\0\0\5\0\14\0\0266\0\0\0'\2\1\0B\0\2\0027\0\2\0004\0\3\0006\1\2\0009\1\3\0019\1\4\0019\1\5\0019\1\6\0015\3\b\0005\4\a\0=\4\t\3B\1\2\2>\1\1\0006\1\2\0009\1\3\0019\1\4\0019\1\n\1>\1\2\0006\1\2\0009\1\v\0015\3\f\0=\0\r\3B\1\2\1K\0\1\0\fsources\1\0\0\nsetup\nisort\15extra_args\1\0\0\1\2\0\0\21--line-length=90\twith\nblack\15formatting\rbuiltins\fnull_ls\fnull-ls\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvcode-color-schemes.vim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvcode-color-schemes.vim",
    url = "https://github.com/christianchiarulli/nvcode-color-schemes.vim"
  },
  ["nvim-autopairs"] = {
    config = { "\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 yasser.completion.autopairs\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30yasser.completion.cmpconf\frequire\0" },
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
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24yasser.debug.dapcfg\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-python"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23yasser.debug.dappy\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/nvim-dap-python",
    url = "https://github.com/mfussenegger/nvim-dap-python"
  },
  ["nvim-dap-ui"] = {
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23yasser.debug.dapui\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
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
    config = { "\27LJ\2\nN\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0016\0\0\0'\2\2\0B\0\2\1K\0\1\0\21yasser.lsp.mason\22yasser.lsp.config\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-notify"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-notify",
    url = "https://github.com/rcarriga/nvim-notify"
  },
  ["nvim-tmux-navigator"] = {
    cond = { "\27LJ\2\nH\0\0\3\0\4\1\v6\0\0\0009\0\1\0009\0\2\0'\2\3\0B\0\2\2\b\0\0\0X\0\2€+\0\1\0X\1\1€+\0\2\0L\0\2\0\n$TMUX\vexists\afn\bvim\2\0" },
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24yasser.nav.tmuxconf\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/nvim-tmux-navigator",
    url = "https://github.com/robaire/nvim-tmux-navigator"
  },
  ["nvim-transparent"] = {
    config = { "\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29yasser.theme.transparent\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-transparent",
    url = "https://github.com/xiyaowong/nvim-transparent"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24yasser.nav.nvimtree\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28yasser.theme.treesitter\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-textobjects"] = {
    config = { "\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&yasser.nav.treesitter_textobjects\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-treesitter-textobjects",
    url = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects"
  },
  ["nvim-ts-autotag"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-ts-autotag",
    url = "https://github.com/windwp/nvim-ts-autotag"
  },
  ["nvim-ts-context-commentstring"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-ts-context-commentstring",
    url = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["one-small-step-for-vimkind"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/one-small-step-for-vimkind",
    url = "https://github.com/jbyuki/one-small-step-for-vimkind"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
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
  ["project.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27yasser.search.projects\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/project.nvim",
    url = "https://github.com/ahmedkhalf/project.nvim"
  },
  ["pytest-vim-compiler"] = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/pytest-vim-compiler",
    url = "https://github.com/5long/pytest-vim-compiler"
  },
  rainbow_csv = {
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/rainbow_csv",
    url = "https://github.com/mechatroner/rainbow_csv"
  },
  sniprun = {
    config = { "\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24yasser.repl.sniprun\frequire\0" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/sniprun",
    url = "https://github.com/michaelb/sniprun"
  },
  ["spellsitter.nvim"] = {
    config = { "\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\16spellsitter\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/spellsitter.nvim",
    url = "https://github.com/lewis6991/spellsitter.nvim"
  },
  ["sqls.nvim"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/sqls.nvim",
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
  ["telescope-file-browser.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/telescope-file-browser.nvim",
    url = "https://github.com/nvim-telescope/telescope-file-browser.nvim"
  },
  ["telescope-fzy-native.nvim"] = {
    config = { "\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\15fzy_native\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/telescope-fzy-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzy-native.nvim"
  },
  ["telescope-media-files.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/telescope-media-files.nvim",
    url = "https://github.com/nvim-telescope/telescope-media-files.nvim"
  },
  ["telescope-packer.nvim"] = {
    config = { "\27LJ\2\nK\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\vpacker\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/telescope-packer.nvim",
    url = "https://github.com/nvim-telescope/telescope-packer.nvim"
  },
  ["telescope-project.nvim"] = {
    config = { "\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\fproject\19load_extension\14telescope\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/telescope-project.nvim",
    url = "https://github.com/nvim-telescope/telescope-project.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim",
    url = "https://github.com/nvim-telescope/telescope-symbols.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope-vim-bookmarks.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/telescope-vim-bookmarks.nvim",
    url = "https://github.com/tom-anders/telescope-vim-bookmarks.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28yasser.search.telescope\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
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
  ["vim-bbye"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-bbye",
    url = "https://github.com/moll/vim-bbye"
  },
  ["vim-better-whitespace"] = {
    config = { "\27LJ\2\nˆ\1\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\n\0\0\14dashboard\nALPHA\tdiff\14gitcommit\nunite\rnvimtree\aqf\thelp\vpacker*better_whitespace_filetypes_blacklist\6g\bvim\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-better-whitespace",
    url = "https://github.com/ntpeters/vim-better-whitespace"
  },
  ["vim-closetag"] = {
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/vim-closetag",
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
  ["vim-fetch"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-fetch",
    url = "https://github.com/wsdjeg/vim-fetch"
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
    commands = { "GrammarousCheck", "GrammarousReset" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/vim-grammarous",
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
  ["vim-matchup"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-matchup",
    url = "https://github.com/andymass/vim-matchup"
  },
  ["vim-pydocstring"] = {
    config = { "\27LJ\2\nJ\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0+let g:pydocstring_formatter = 'google'\bcmd\bvim\0" },
    loaded = false,
    needs_bufread = true,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/vim-pydocstring",
    url = "https://github.com/heavenshell/vim-pydocstring"
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
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/opt/vim-test",
    url = "https://github.com/janko/vim-test"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/vim-unimpaired",
    url = "https://github.com/tpope/vim-unimpaired"
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
    config = { "\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23yasser.whichkeymap\frequire\0" },
    loaded = true,
    path = "/Users/yasser/.local/share/nvim/site/pack/packer/start/which-key.nvim",
    url = "https://github.com/folke/which-key.nvim"
  }
}

time([[Defining packer_plugins]], false)
local module_lazy_loads = {
  ["^neogen"] = "neogen"
}
local lazy_load_called = {['packer.load'] = true}
local function lazy_load_module(module_name)
  local to_load = {}
  if lazy_load_called[module_name] then return nil end
  lazy_load_called[module_name] = true
  for module_pat, plugin_name in pairs(module_lazy_loads) do
    if not _G.packer_plugins[plugin_name].loaded and string.match(module_name, module_pat) then
      to_load[#to_load + 1] = plugin_name
    end
  end

  if #to_load > 0 then
    require('packer.load')(to_load, {module = module_name}, _G.packer_plugins)
    local loaded_mod = package.loaded[module_name]
    if loaded_mod then
      return function(modname) return loaded_mod end
    end
  end
end

if not vim.g.packer_custom_loader_enabled then
  table.insert(package.loaders, 1, lazy_load_module)
  vim.g.packer_custom_loader_enabled = true
end

-- Setup for: neoformat
time([[Setup for neoformat]], true)
try_loadstring("\27LJ\2\nP\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0001 let g:neoformat_enabled_python = ['black'] \bcmd\bvim\0", "setup", "neoformat")
time([[Setup for neoformat]], false)
time([[packadd for neoformat]], true)
vim.cmd [[packadd neoformat]]
time([[packadd for neoformat]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28yasser.search.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30yasser.completion.cmpconf\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-treesitter-textobjects
time([[Config for nvim-treesitter-textobjects]], true)
try_loadstring("\27LJ\2\nA\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0&yasser.nav.treesitter_textobjects\frequire\0", "config", "nvim-treesitter-textobjects")
time([[Config for nvim-treesitter-textobjects]], false)
-- Config for: telescope-fzy-native.nvim
time([[Config for telescope-fzy-native.nvim]], true)
try_loadstring("\27LJ\2\nO\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\15fzy_native\19load_extension\14telescope\frequire\0", "config", "telescope-fzy-native.nvim")
time([[Config for telescope-fzy-native.nvim]], false)
-- Config for: spellsitter.nvim
time([[Config for spellsitter.nvim]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\16spellsitter\frequire\0", "config", "spellsitter.nvim")
time([[Config for spellsitter.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28yasser.theme.treesitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-comment
time([[Config for nvim-comment]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\17nvim_comment\frequire\0", "config", "nvim-comment")
time([[Config for nvim-comment]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24yasser.nav.nvimtree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: telescope-project.nvim
time([[Config for telescope-project.nvim]], true)
try_loadstring("\27LJ\2\nL\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\fproject\19load_extension\14telescope\frequire\0", "config", "telescope-project.nvim")
time([[Config for telescope-project.nvim]], false)
-- Config for: fzf-lua
time([[Config for fzf-lua]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25yasser.search.fzflua\frequire\0", "config", "fzf-lua")
time([[Config for fzf-lua]], false)
-- Config for: bufferline.nvim
time([[Config for bufferline.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\28yasser.theme.bufferline\frequire\0", "config", "bufferline.nvim")
time([[Config for bufferline.nvim]], false)
-- Config for: telescope-packer.nvim
time([[Config for telescope-packer.nvim]], true)
try_loadstring("\27LJ\2\nK\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0'\2\3\0B\0\2\1K\0\1\0\vpacker\19load_extension\14telescope\frequire\0", "config", "telescope-packer.nvim")
time([[Config for telescope-packer.nvim]], false)
-- Config for: which-key.nvim
time([[Config for which-key.nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23yasser.whichkeymap\frequire\0", "config", "which-key.nvim")
time([[Config for which-key.nvim]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
try_loadstring("\27LJ\2\n2\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\23yasser.theme.alpha\frequire\0", "config", "alpha-nvim")
time([[Config for alpha-nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n4\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\25yasser.theme.lualine\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: indent-blankline.nvim
time([[Config for indent-blankline.nvim]], true)
try_loadstring("\27LJ\2\n=\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\"yasser.theme.indent-blankline\frequire\0", "config", "indent-blankline.nvim")
time([[Config for indent-blankline.nvim]], false)
-- Config for: project.nvim
time([[Config for project.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\27yasser.search.projects\frequire\0", "config", "project.nvim")
time([[Config for project.nvim]], false)
-- Config for: null-ls.nvim
time([[Config for null-ls.nvim]], true)
try_loadstring("\27LJ\2\nà\1\0\0\5\0\14\0\0266\0\0\0'\2\1\0B\0\2\0027\0\2\0004\0\3\0006\1\2\0009\1\3\0019\1\4\0019\1\5\0019\1\6\0015\3\b\0005\4\a\0=\4\t\3B\1\2\2>\1\1\0006\1\2\0009\1\3\0019\1\4\0019\1\n\1>\1\2\0006\1\2\0009\1\v\0015\3\f\0=\0\r\3B\1\2\1K\0\1\0\fsources\1\0\0\nsetup\nisort\15extra_args\1\0\0\1\2\0\0\21--line-length=90\twith\nblack\15formatting\rbuiltins\fnull_ls\fnull-ls\frequire\0", "config", "null-ls.nvim")
time([[Config for null-ls.nvim]], false)
-- Config for: nvim-autopairs
time([[Config for nvim-autopairs]], true)
try_loadstring("\27LJ\2\n;\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0 yasser.completion.autopairs\frequire\0", "config", "nvim-autopairs")
time([[Config for nvim-autopairs]], false)
-- Config for: nvim-transparent
time([[Config for nvim-transparent]], true)
try_loadstring("\27LJ\2\n8\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\29yasser.theme.transparent\frequire\0", "config", "nvim-transparent")
time([[Config for nvim-transparent]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\n9\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\30yasser.completion.luasnip\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n3\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\24yasser.git.gitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: vim-better-whitespace
time([[Config for vim-better-whitespace]], true)
try_loadstring("\27LJ\2\nˆ\1\0\0\2\0\4\0\0056\0\0\0009\0\1\0005\1\3\0=\1\2\0K\0\1\0\1\n\0\0\14dashboard\nALPHA\tdiff\14gitcommit\nunite\rnvimtree\aqf\thelp\vpacker*better_whitespace_filetypes_blacklist\6g\bvim\0", "config", "vim-better-whitespace")
time([[Config for vim-better-whitespace]], false)
-- Conditional loads
time([[Conditional loading of nvim-tmux-navigator]], true)
  require("packer.load")({"nvim-tmux-navigator"}, {}, _G.packer_plugins)
time([[Conditional loading of nvim-tmux-navigator]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GrammarousReset lua require("packer.load")({'vim-grammarous'}, { cmd = "GrammarousReset", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIUninstall lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIUninstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIInstall lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIInstall", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neogen lua require("packer.load")({'neogen'}, { cmd = "Neogen", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file DIList lua require("packer.load")({'DAPInstall.nvim'}, { cmd = "DIList", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file GrammarousCheck lua require("packer.load")({'vim-grammarous'}, { cmd = "GrammarousCheck", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
time([[Defining lazy-load filetype autocommands]], true)
vim.cmd [[au FileType cpp ++once lua require("packer.load")({'code_runner.nvim', 'nvim-dap-virtual-text', 'nvim-dap-ui', 'nvim-dap', 'telescope-dap.nvim'}, { ft = "cpp" }, _G.packer_plugins)]]
vim.cmd [[au FileType js ++once lua require("packer.load")({'code_runner.nvim', 'nvim-dap-virtual-text', 'nvim-dap-ui', 'nvim-dap', 'telescope-dap.nvim'}, { ft = "js" }, _G.packer_plugins)]]
vim.cmd [[au FileType md ++once lua require("packer.load")({'sniprun'}, { ft = "md" }, _G.packer_plugins)]]
vim.cmd [[au FileType python ++once lua require("packer.load")({'code_runner.nvim', 'vim-test', 'vim-pydocstring', 'nvim-dap-virtual-text', 'nvim-dap-ui', 'nvim-dap-python', 'nvim-dap', 'telescope-dap.nvim', 'sniprun', 'pytest-vim-compiler'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType lua ++once lua require("packer.load")({'code_runner.nvim', 'one-small-step-for-vimkind', 'nvim-dap-virtual-text', 'nvim-dap-ui', 'nvim-dap', 'telescope-dap.nvim', 'nlua.nvim'}, { ft = "lua" }, _G.packer_plugins)]]
vim.cmd [[au FileType tex ++once lua require("packer.load")({'vimtex'}, { ft = "tex" }, _G.packer_plugins)]]
vim.cmd [[au FileType bib ++once lua require("packer.load")({'vimtex'}, { ft = "bib" }, _G.packer_plugins)]]
vim.cmd [[au FileType java ++once lua require("packer.load")({'code_runner.nvim', 'nvim-dap-virtual-text', 'nvim-dap-ui', 'nvim-dap', 'telescope-dap.nvim'}, { ft = "java" }, _G.packer_plugins)]]
vim.cmd [[au FileType xml ++once lua require("packer.load")({'vim-closetag'}, { ft = "xml" }, _G.packer_plugins)]]
vim.cmd [[au FileType sql ++once lua require("packer.load")({'sqls.nvim'}, { ft = "sql" }, _G.packer_plugins)]]
vim.cmd [[au FileType csv ++once lua require("packer.load")({'rainbow_csv'}, { ft = "csv" }, _G.packer_plugins)]]
vim.cmd [[au FileType html ++once lua require("packer.load")({'vim-closetag'}, { ft = "html" }, _G.packer_plugins)]]
vim.cmd [[au FileType php ++once lua require("packer.load")({'code_runner.nvim', 'nvim-dap-virtual-text', 'nvim-dap-ui', 'nvim-dap', 'vim-closetag', 'telescope-dap.nvim'}, { ft = "php" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown', 'markdown-preview.nvim'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd [[au FileType c ++once lua require("packer.load")({'code_runner.nvim', 'nvim-dap-virtual-text', 'nvim-dap-ui', 'nvim-dap', 'telescope-dap.nvim'}, { ft = "c" }, _G.packer_plugins)]]
time([[Defining lazy-load filetype autocommands]], false)
  -- Event lazy-loads
time([[Defining lazy-load event autocommands]], true)
vim.cmd [[au BufReadPre * ++once lua require("packer.load")({'dressing.nvim', 'nvim-lspconfig'}, { event = "BufReadPre *" }, _G.packer_plugins)]]
time([[Defining lazy-load event autocommands]], false)
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

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
