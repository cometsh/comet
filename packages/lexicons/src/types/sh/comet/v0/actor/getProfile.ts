import type {} from "@atcute/lexicons";
import * as v from "@atcute/lexicons/validations";
import type {} from "@atcute/lexicons/ambient";
import * as ShCometV0ActorProfile from "./profile.js";

const _mainSchema = /*#__PURE__*/ v.query("sh.comet.v0.actor.getProfile", {
  params: /*#__PURE__*/ v.object({
    actor: /*#__PURE__*/ v.actorIdentifierString(),
  }),
  output: {
    type: "lex",
    get schema() {
      return ShCometV0ActorProfile.viewSchema;
    },
  },
});

type main$schematype = typeof _mainSchema;

export interface mainSchema extends main$schematype {}

export const mainSchema = _mainSchema as mainSchema;

declare module "@atcute/lexicons/ambient" {
  interface XRPCQueries {
    "sh.comet.v0.actor.getProfile": mainSchema;
  }
}
