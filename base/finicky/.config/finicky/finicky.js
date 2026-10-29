// Finicky (the default browser) hands each link to the browser of the first matching rule, else to
// defaultBrowser. Edit with `browser-rule ls|add|rm|default|edit` (~/bin) or by hand: one
// "pattern": "Browser" line per rule. Patterns are Finicky wildcards on host/path, * = anything.
// Finicky reloads this file when it changes.
const rules = {
  "scholar.google.com/*": "Microsoft Edge",
  "localhost": "Microsoft Edge",
  "localhost:*/*": "Microsoft Edge",
  "github.com/orgs/swfg1200198": "Microsoft Edge",
  "github.com/orgs/swfg1200198/*": "Microsoft Edge",
  "github.com/swfg1200198": "Microsoft Edge",
  "github.com/swfg1200198/*": "Microsoft Edge",
  "nec.com": "Microsoft Edge",
  "nec.com/*": "Microsoft Edge",
  "*.nec.com": "Microsoft Edge",
  "*.nec.com/*": "Microsoft Edge",
  "nec.co.jp": "Microsoft Edge",
  "nec.co.jp/*": "Microsoft Edge",
  "*.nec.co.jp": "Microsoft Edge",
  "*.nec.co.jp/*": "Microsoft Edge",
  "state.gov": "Microsoft Edge",
  "state.gov/*": "Microsoft Edge",
  "*.state.gov": "Microsoft Edge",
  "*.state.gov/*": "Microsoft Edge",
  "usvisa-info.com": "Microsoft Edge",
  "usvisa-info.com/*": "Microsoft Edge",
  "*.usvisa-info.com": "Microsoft Edge",
  "*.usvisa-info.com/*": "Microsoft Edge",
  "ustraveldocs.com": "Microsoft Edge",
  "ustraveldocs.com/*": "Microsoft Edge",
  "*.ustraveldocs.com": "Microsoft Edge",
  "*.ustraveldocs.com/*": "Microsoft Edge",
  "*.usembassy.gov": "Microsoft Edge",
  "*.usembassy.gov/*": "Microsoft Edge",
};

export default {
  defaultBrowser: "Safari",
  handlers: Object.entries(rules).map(([match, browser]) => ({ match, browser })),
};
