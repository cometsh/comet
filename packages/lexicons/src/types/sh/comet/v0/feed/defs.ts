import type {} from "@atcute/lexicons";
import * as v from "@atcute/lexicons/validations";

const _buyLinkSchema = /*#__PURE__*/ v.literal("sh.comet.v0.feed.defs#buyLink");
const _downloadLinkSchema = /*#__PURE__*/ v.literal(
  "sh.comet.v0.feed.defs#downloadLink",
);
const _linkSchema = /*#__PURE__*/ v.object({
  $type: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.literal("sh.comet.v0.feed.defs#link"),
  ),
  type: /*#__PURE__*/ v.string<
    | "sh.comet.v0.feed.defs#buyLink"
    | "sh.comet.v0.feed.defs#downloadLink"
    | (string & {})
  >(),
  value: /*#__PURE__*/ v.genericUriString(),
});
const _viewerStateSchema = /*#__PURE__*/ v.object({
  $type: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.literal("sh.comet.v0.feed.defs#viewerState"),
  ),
  like: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.resourceUriString()),
  repost: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.resourceUriString()),
});

type buyLink$schematype = typeof _buyLinkSchema;
type downloadLink$schematype = typeof _downloadLinkSchema;
type link$schematype = typeof _linkSchema;
type viewerState$schematype = typeof _viewerStateSchema;

export interface buyLinkSchema extends buyLink$schematype {}
export interface downloadLinkSchema extends downloadLink$schematype {}
export interface linkSchema extends link$schematype {}
export interface viewerStateSchema extends viewerState$schematype {}

export const buyLinkSchema = _buyLinkSchema as buyLinkSchema;
export const downloadLinkSchema = _downloadLinkSchema as downloadLinkSchema;
export const linkSchema = _linkSchema as linkSchema;
export const viewerStateSchema = _viewerStateSchema as viewerStateSchema;

export type BuyLink = v.InferInput<typeof buyLinkSchema>;
export type DownloadLink = v.InferInput<typeof downloadLinkSchema>;
export interface Link extends v.InferInput<typeof linkSchema> {}
export interface ViewerState extends v.InferInput<typeof viewerStateSchema> {}
