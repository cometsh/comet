import type {} from "@atcute/lexicons";
import * as v from "@atcute/lexicons/validations";
import type {} from "@atcute/lexicons/ambient";
import * as ShCometV0ActorProfile from "./profile.js";

const _mainSchema = /*#__PURE__*/ v.query("sh.comet.v0.actor.getProfiles", {
  params: /*#__PURE__*/ v.object({
    actors: /*#__PURE__*/ v.constrain(
      /*#__PURE__*/ v.array(/*#__PURE__*/ v.actorIdentifierString()),
      [/*#__PURE__*/ v.arrayLength(0, 25)],
    ),
  }),
  output: {
    type: "lex",
    schema: /*#__PURE__*/ v.object({
      get profiles() {
        return /*#__PURE__*/ v.array(ShCometV0ActorProfile.viewSchema);
      },
    }),
  },
});

type main$schematype = typeof _mainSchema;

export interface mainSchema extends main$schematype {}

export const mainSchema = _mainSchema as mainSchema;

declare module "@atcute/lexicons/ambient" {
  interface XRPCQueries {
    "sh.comet.v0.actor.getProfiles": mainSchema;
  }
}
