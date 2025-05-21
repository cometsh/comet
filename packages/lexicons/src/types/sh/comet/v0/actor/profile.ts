import type {} from "@atcute/lexicons";
import * as v from "@atcute/lexicons/validations";
import type {} from "@atcute/lexicons/ambient";
import * as ShCometV0RichtextFacet from "../richtext/facet.js";

const _mainSchema = /*#__PURE__*/ v.record(
  /*#__PURE__*/ v.literal("self"),
  /*#__PURE__*/ v.object({
    $type: /*#__PURE__*/ v.literal("sh.comet.v0.actor.profile"),
    avatar: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.blob()),
    banner: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.blob()),
    createdAt: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.datetimeString()),
    description: /*#__PURE__*/ v.optional(
      /*#__PURE__*/ v.constrain(/*#__PURE__*/ v.string(), [
        /*#__PURE__*/ v.stringLength(0, 2560),
        /*#__PURE__*/ v.stringGraphemes(0, 256),
      ]),
    ),
    get descriptionFacets() {
      return /*#__PURE__*/ v.optional(ShCometV0RichtextFacet.mainSchema);
    },
    displayName: /*#__PURE__*/ v.optional(
      /*#__PURE__*/ v.constrain(/*#__PURE__*/ v.string(), [
        /*#__PURE__*/ v.stringLength(0, 640),
        /*#__PURE__*/ v.stringGraphemes(0, 64),
      ]),
    ),
    featuredItems: /*#__PURE__*/ v.optional(
      /*#__PURE__*/ v.constrain(
        /*#__PURE__*/ v.array(/*#__PURE__*/ v.resourceUriString()),
        [/*#__PURE__*/ v.arrayLength(0, 5)],
      ),
    ),
  }),
);
const _viewSchema = /*#__PURE__*/ v.object({
  $type: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.literal("sh.comet.v0.actor.profile#view"),
  ),
  avatar: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.genericUriString()),
  createdAt: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.datetimeString()),
  description: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.constrain(/*#__PURE__*/ v.string(), [
      /*#__PURE__*/ v.stringLength(0, 2560),
      /*#__PURE__*/ v.stringGraphemes(0, 256),
    ]),
  ),
  get descriptionFacets() {
    return /*#__PURE__*/ v.optional(ShCometV0RichtextFacet.mainSchema);
  },
  did: /*#__PURE__*/ v.didString(),
  displayName: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.constrain(/*#__PURE__*/ v.string(), [
      /*#__PURE__*/ v.stringLength(0, 640),
      /*#__PURE__*/ v.stringGraphemes(0, 64),
    ]),
  ),
  handle: /*#__PURE__*/ v.handleString(),
  indexedAt: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.datetimeString()),
  viewer: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.unknown()),
});
const _viewFullSchema = /*#__PURE__*/ v.object({
  $type: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.literal("sh.comet.v0.actor.profile#viewFull"),
  ),
  avatar: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.genericUriString()),
  banner: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.genericUriString()),
  createdAt: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.datetimeString()),
  description: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.constrain(/*#__PURE__*/ v.string(), [
      /*#__PURE__*/ v.stringLength(0, 2560),
      /*#__PURE__*/ v.stringGraphemes(0, 256),
    ]),
  ),
  get descriptionFacets() {
    return /*#__PURE__*/ v.optional(ShCometV0RichtextFacet.mainSchema);
  },
  did: /*#__PURE__*/ v.didString(),
  displayName: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.constrain(/*#__PURE__*/ v.string(), [
      /*#__PURE__*/ v.stringLength(0, 640),
      /*#__PURE__*/ v.stringGraphemes(0, 64),
    ]),
  ),
  featuredItems: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.constrain(
      /*#__PURE__*/ v.array(/*#__PURE__*/ v.resourceUriString()),
      [/*#__PURE__*/ v.arrayLength(0, 5)],
    ),
  ),
  followersCount: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.integer()),
  followsCount: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.integer()),
  handle: /*#__PURE__*/ v.handleString(),
  indexedAt: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.datetimeString()),
  playlistsCount: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.integer()),
  tracksCount: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.integer()),
  viewer: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.unknown()),
});

type main$schematype = typeof _mainSchema;
type view$schematype = typeof _viewSchema;
type viewFull$schematype = typeof _viewFullSchema;

export interface mainSchema extends main$schematype {}
export interface viewSchema extends view$schematype {}
export interface viewFullSchema extends viewFull$schematype {}

export const mainSchema = _mainSchema as mainSchema;
export const viewSchema = _viewSchema as viewSchema;
export const viewFullSchema = _viewFullSchema as viewFullSchema;

export interface Main extends v.InferInput<typeof mainSchema> {}
export interface View extends v.InferInput<typeof viewSchema> {}
export interface ViewFull extends v.InferInput<typeof viewFullSchema> {}

declare module "@atcute/lexicons/ambient" {
  interface Records {
    "sh.comet.v0.actor.profile": mainSchema;
  }
}
