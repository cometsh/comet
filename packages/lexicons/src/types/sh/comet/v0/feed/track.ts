import type {} from "@atcute/lexicons";
import * as v from "@atcute/lexicons/validations";
import type {} from "@atcute/lexicons/ambient";
import * as ShCometV0ActorProfile from "../actor/profile.js";
import * as ShCometV0FeedDefs from "./defs.js";
import * as ShCometV0RichtextFacet from "../richtext/facet.js";

const _mainSchema = /*#__PURE__*/ v.record(
  /*#__PURE__*/ v.tidString(),
  /*#__PURE__*/ v.object({
    $type: /*#__PURE__*/ v.literal("sh.comet.v0.feed.track"),
    audio: /*#__PURE__*/ v.blob(),
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
  }),
);
const _viewSchema = /*#__PURE__*/ v.object({
  $type: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.literal("sh.comet.v0.feed.track#view"),
  ),
  audio: /*#__PURE__*/ v.genericUriString(),
  get author() {
    return ShCometV0ActorProfile.viewFullSchema;
  },
  cid: /*#__PURE__*/ v.cidString(),
  commentCount: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.integer()),
  image: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.genericUriString()),
  indexedAt: /*#__PURE__*/ v.datetimeString(),
  likeCount: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.integer()),
  playCount: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.integer()),
  get record() {
    return mainSchema;
  },
  repostCount: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.integer()),
  uri: /*#__PURE__*/ v.resourceUriString(),
  get viewer() {
    return /*#__PURE__*/ v.optional(ShCometV0FeedDefs.viewerStateSchema);
  },
});

type main$schematype = typeof _mainSchema;
type view$schematype = typeof _viewSchema;

export interface mainSchema extends main$schematype {}
export interface viewSchema extends view$schematype {}

export const mainSchema = _mainSchema as mainSchema;
export const viewSchema = _viewSchema as viewSchema;

export interface Main extends v.InferInput<typeof mainSchema> {}
export interface View extends v.InferInput<typeof viewSchema> {}

declare module "@atcute/lexicons/ambient" {
  interface Records {
    "sh.comet.v0.feed.track": mainSchema;
  }
}
