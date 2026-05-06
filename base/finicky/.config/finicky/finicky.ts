const config: Finicky.Config = {
  defaultBrowser: "Safari",
  rules: [
    {
      match: [
        "scholar.google.com/*",
        "localhost:*",
        "localhost",
      ],
      browser: "Microsoft Edge",
    },
  ],
};
