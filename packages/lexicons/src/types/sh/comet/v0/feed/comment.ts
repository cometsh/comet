import type {} from "@atcute/lexicons";
import * as v from "@atcute/lexicons/validations";
import type {} from "@atcute/lexicons/ambient";
import * as ShCometV0RichtextFacet from "../richtext/facet.js";

const _mainSchema = /*#__PURE__*/ v.record(
  /*#__PURE__*/ v.tidString(),
  /*#__PURE__*/ v.object({
    $type: /*#__PURE__*/ v.literal("sh.comet.v0.feed.comment"),
    createdAt: /*#__PURE__*/ v.datetimeString(),
    get facets() {
      return /*#__PURE__*/ v.optional(
        /*#__PURE__*/ v.array(ShCometV0RichtextFacet.mainSchema),
      );
    },
    langs: /*#__PURE__*/ v.optional(
      /*#__PURE__*/ v.constrain(
        /*#__PURE__*/ v.array(/*#__PURE__*/ v.languageCodeString()),
        [/*#__PURE__*/ v.arrayLength(0, 3)],
      ),
    ),
    reply: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.resourceUriString()),
    subject: /*#__PURE__*/ v.resourceUriString(),
    text: /*#__PURE__*/ v.constrain(/*#__PURE__*/ v.string(), [
      /*#__PURE__*/ v.stringLength(1, 3000),
      /*#__PURE__*/ v.stringGraphemes(1, 300),
    ]),
  }),
);

type main$schematype = typeof _mainSchema;

export interface mainSchema extends main$schematype {}

export const mainSchema = _mainSchema as mainSchema;

export interface Main extends v.InferInput<typeof mainSchema> {}

declare module "@atcute/lexicons/ambient" {
  interface Records {
    "sh.comet.v0.feed.comment": mainSchema;
  }
}
