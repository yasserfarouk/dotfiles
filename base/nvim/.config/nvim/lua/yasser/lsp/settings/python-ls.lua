-- npm i -g pyright
require("lspconfig").pyright.setup {
  settings = {
    python = {
      analysis = {
        extraPaths = {"/Users/code/projects/negmas"}
      }
    }
  }
}
