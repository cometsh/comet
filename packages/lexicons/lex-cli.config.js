import { defineLexiconConfig } from "@atcute/lex-cli";

export default defineLexiconConfig({
  files: ["./defs/sh/comet/v0/**/*.json"],
  outdir: "./src",
});
