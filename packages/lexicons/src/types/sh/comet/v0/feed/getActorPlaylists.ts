import type {} from "@atcute/lexicons";
import * as v from "@atcute/lexicons/validations";
import type {} from "@atcute/lexicons/ambient";
import * as ShCometV0FeedPlaylist from "./playlist.js";

const _mainSchema = /*#__PURE__*/ v.query(
  "sh.comet.v0.feed.getActorPlaylists",
  {
    params: /*#__PURE__*/ v.object({
      actor: /*#__PURE__*/ v.actorIdentifierString(),
      cursor: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.string()),
      limit: /*#__PURE__*/ v.optional(
        /*#__PURE__*/ v.constrain(/*#__PURE__*/ v.integer(), [
          /*#__PURE__*/ v.integerRange(1, 100),
        ]),
        50,
      ),
    }),
    output: {
      type: "lex",
      schema: /*#__PURE__*/ v.object({
        cursor: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.string()),
        get playlists() {
          return /*#__PURE__*/ v.array(ShCometV0FeedPlaylist.viewSchema);
        },
      }),
    },
  },
);

type main$schematype = typeof _mainSchema;

export interface mainSchema extends main$schematype {}

export const mainSchema = _mainSchema as mainSchema;

declare module "@atcute/lexicons/ambient" {
  interface XRPCQueries {
    "sh.comet.v0.feed.getActorPlaylists": mainSchema;
  }
}
