vim.g.mapleader = " "
vim.g.maplocalleader = ","
local execute = vim.api.nvim_command
local fn = vim.fn
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- function OnPluginRecompile()
-- 	vim.cmd([[source %]])
-- end
--
-- vim.cmd([[
--   augroup packer_user_config
--   autocmd!
--   autocmd BufWritePost plugins.lua lua OnPluginRecompile()
--   augroup end
-- ]])
-- helpers. taken from datwaft https://github.com/datwaft/nvim/blob/master/lua/plugins/init.lua
return require("lazy").setup( "plugins")
