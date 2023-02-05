local neogen = require("neogen")
neogen.setup {
snippet_engine = "snippy",
enabled = true,
languages = {
  lua = {
	template = {
	  annotation_convention = "ldoc",
	},
  },
  python = {
	template = {
	  annotation_convention = "google_docstrings",
	},
  },
  rust = {
	template = {
	  annotation_convention = "rustdoc",
	},
  },
  javascript = {
	template = {
	  annotation_convention = "jsdoc",
	},
  },
  typescript = {
	template = {
	  annotation_convention = "tsdoc",
	},
  },
  typescriptreact = {
	template = {
	  annotation_convention = "tsdoc",
	},
  },
},
}
