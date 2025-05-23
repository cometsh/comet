import type {} from "@atcute/lexicons";
import * as v from "@atcute/lexicons/validations";
import type {} from "@atcute/lexicons/ambient";
import * as ShCometV0ActorProfile from "../actor/profile.js";
import * as ShCometV0FeedDefs from "./defs.js";
import * as ShCometV0FeedTrack from "./track.js";
import * as ShCometV0RichtextFacet from "../richtext/facet.js";

const _albumSchema = /*#__PURE__*/ v.literal("sh.comet.v0.feed.playlist#album");
const _compilationSchema = /*#__PURE__*/ v.literal(
  "sh.comet.v0.feed.playlist#compilation",
);
const _mainSchema = /*#__PURE__*/ v.record(
  /*#__PURE__*/ v.tidString(),
  /*#__PURE__*/ v.object({
    $type: /*#__PURE__*/ v.literal("sh.comet.v0.feed.playlist"),
    createdAt: /*#__PURE__*/ v.datetimeString(),
    description: /*#__PURE__*/ v.optional(
      /*#__PURE__*/ v.constrain(/*#__PURE__*/ v.string(), [
        /*#__PURE__*/ v.stringLength(0, 20000),
        /*#__PURE__*/ v.stringGraphemes(0, 2000),
      ]),
    ),
    get descriptionFacets() {
      return /*#__PURE__*/ v.optional(ShCometV0RichtextFacet.mainSchema);
    },
    image: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.blob()),
    get link() {
      return /*#__PURE__*/ v.optional(ShCometV0FeedDefs.linkSchema);
    },
    tags: /*#__PURE__*/ v.optional(
      /*#__PURE__*/ v.constrain(
        /*#__PURE__*/ v.array(
          /*#__PURE__*/ v.constrain(/*#__PURE__*/ v.string(), [
            /*#__PURE__*/ v.stringLength(0, 640),
            /*#__PURE__*/ v.stringGraphemes(0, 64),
          ]),
        ),
        [/*#__PURE__*/ v.arrayLength(0, 8)],
      ),
    ),
    title: /*#__PURE__*/ v.constrain(/*#__PURE__*/ v.string(), [
      /*#__PURE__*/ v.stringLength(1, 2560),
      /*#__PURE__*/ v.stringGraphemes(0, 256),
    ]),
    type: /*#__PURE__*/ v.string<
      | "sh.comet.v0.feed.playlist#album"
      | "sh.comet.v0.feed.playlist#compilation"
      | "sh.comet.v0.feed.playlist#playlist"
      | "sh.comet.v0.feed.playlist#podcast"
      | (string & {})
    >(),
  }),
);
const _playlistSchema = /*#__PURE__*/ v.literal(
  "sh.comet.v0.feed.playlist#playlist",
);
const _podcastSchema = /*#__PURE__*/ v.literal(
  "sh.comet.v0.feed.playlist#podcast",
);
const _viewSchema = /*#__PURE__*/ v.object({
  $type: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.literal("sh.comet.v0.feed.playlist#view"),
  ),
  get author() {
    return ShCometV0ActorProfile.viewFullSchema;
  },
  cid: /*#__PURE__*/ v.cidString(),
  commentCount: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.integer()),
  image: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.genericUriString()),
  indexedAt: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.datetimeString()),
  likeCount: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.integer()),
  get record() {
    return mainSchema;
  },
  repostCount: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.integer()),
  trackCount: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.integer()),
  get tracks() {
    return /*#__PURE__*/ v.array(ShCometV0FeedTrack.viewSchema);
  },
  uri: /*#__PURE__*/ v.resourceUriString(),
  get viewer() {
    return /*#__PURE__*/ v.optional(ShCometV0FeedDefs.viewerStateSchema);
  },
});

type album$schematype = typeof _albumSchema;
type compilation$schematype = typeof _compilationSchema;
type main$schematype = typeof _mainSchema;
type playlist$schematype = typeof _playlistSchema;
type podcast$schematype = typeof _podcastSchema;
type view$schematype = typeof _viewSchema;

export interface albumSchema extends album$schematype {}
export interface compilationSchema extends compilation$schematype {}
export interface mainSchema extends main$schematype {}
export interface playlistSchema extends playlist$schematype {}
export interface podcastSchema extends podcast$schematype {}
export interface viewSchema extends view$schematype {}

export const albumSchema = _albumSchema as albumSchema;
export const compilationSchema = _compilationSchema as compilationSchema;
export const mainSchema = _mainSchema as mainSchema;
export const playlistSchema = _playlistSchema as playlistSchema;
export const podcastSchema = _podcastSchema as podcastSchema;
export const viewSchema = _viewSchema as viewSchema;

export type Album = v.InferInput<typeof albumSchema>;
export type Compilation = v.InferInput<typeof compilationSchema>;
export interface Main extends v.InferInput<typeof mainSchema> {}
export type Playlist = v.InferInput<typeof playlistSchema>;
export type Podcast = v.InferInput<typeof podcastSchema>;
export interface View extends v.InferInput<typeof viewSchema> {}

declare module "@atcute/lexicons/ambient" {
  interface Records {
    "sh.comet.v0.feed.playlist": mainSchema;
  }
}
