require'lspconfig'.texlab.setup {
	-- cmd = {~/.local/share/nvim/lsp_servers/latex/texlab }
    cmd = {DATA_PATH .. "/lsp_servers/latex/texlab"},
    on_attach = require'lsp'.common_on_attach,
    settings = {
        latex = {
            build = {
                -- args = {"-pdf", "-interaction=nonstopmode", "-synctex=1", "-pvc"},
                args = {"-pdf", "-interaction=nonstopmode", "-synctex=1", "%f"},
                onSave = true,
                forwardSearchAfter = true,
                forwardSearch = {executable = "zathura", args = {"--synctex-forward", "%l:1:%f", "%p"}, onSave = true}
            }
        },
        bibtex = {formatting = {lineLength = 79}}
    }
}
