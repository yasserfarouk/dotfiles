// ~/.finicky.js
export default {
  defaultBrowser: "Safari",
  handlers: [
    {
      match: [
        "scholar.google.com/*",
        "localhost",
        "localhost:*/*",
      ],
      browser: "Microsoft Edge",
    },
  ],
};
