require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = { enable = true },
    playground = {enable = true, updatetime = 50, persist_queries = false},
    indent = {enable = true },
    -- indent = {enable = {"javascriptreact"}},
    autotag = {enable = true},
    rainbow = {enable = true}
}

