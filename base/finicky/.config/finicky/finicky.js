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
  "nec.anaqua.com": "Microsoft Edge",
  "nec.anaqua.com/*": "Microsoft Edge",
  "necglobal.sharepoint.com": "Microsoft Edge",
  "necglobal.sharepoint.com/*": "Microsoft Edge",
  "necglobal-my.sharepoint.com": "Microsoft Edge",
  "necglobal-my.sharepoint.com/*": "Microsoft Edge",
};

const settings = { defaultBrowser: "Safari" };

// Safari and Edge links go through helper apps (`browser-rule helpers`) that open them in the
// current AeroSpace workspace: a new tab in the browser's window there, else a new window.
const here = { "Safari": "com.yasser.safari-here", "Microsoft Edge": "com.yasser.edge-here" };
const viaHere = (browser) => (here[browser] ? { name: here[browser], appType: "bundleId" } : browser);

export default {
  defaultBrowser: viaHere(settings.defaultBrowser),
  handlers: Object.entries(rules).map(([match, browser]) => ({ match, browser: viaHere(browser) })),
};
