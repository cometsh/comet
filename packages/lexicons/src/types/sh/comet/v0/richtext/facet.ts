import type {} from "@atcute/lexicons";
import * as v from "@atcute/lexicons/validations";

const _byteSliceSchema = /*#__PURE__*/ v.object({
  $type: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.literal("sh.comet.v0.richtext.facet#byteSlice"),
  ),
  byteEnd: /*#__PURE__*/ v.integer(),
  byteStart: /*#__PURE__*/ v.integer(),
});
const _linkSchema = /*#__PURE__*/ v.object({
  $type: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.literal("sh.comet.v0.richtext.facet#link"),
  ),
  uri: /*#__PURE__*/ v.genericUriString(),
});
const _mainSchema = /*#__PURE__*/ v.object({
  $type: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.literal("sh.comet.v0.richtext.facet"),
  ),
  get features() {
    return /*#__PURE__*/ v.array(
      /*#__PURE__*/ v.variant([linkSchema, mentionSchema, tagSchema]),
    );
  },
  get index() {
    return byteSliceSchema;
  },
});
const _mentionSchema = /*#__PURE__*/ v.object({
  $type: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.literal("sh.comet.v0.richtext.facet#mention"),
  ),
  did: /*#__PURE__*/ v.didString(),
});
const _tagSchema = /*#__PURE__*/ v.object({
  $type: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.literal("sh.comet.v0.richtext.facet#tag"),
  ),
  tag: /*#__PURE__*/ v.constrain(/*#__PURE__*/ v.string(), [
    /*#__PURE__*/ v.stringLength(0, 640),
    /*#__PURE__*/ v.stringGraphemes(0, 64),
  ]),
});
const _timestampSchema = /*#__PURE__*/ v.object({
  $type: /*#__PURE__*/ v.optional(
    /*#__PURE__*/ v.literal("sh.comet.v0.richtext.facet#timestamp"),
  ),
  timestamp: /*#__PURE__*/ v.optional(/*#__PURE__*/ v.integer()),
});

type byteSlice$schematype = typeof _byteSliceSchema;
type link$schematype = typeof _linkSchema;
type main$schematype = typeof _mainSchema;
type mention$schematype = typeof _mentionSchema;
type tag$schematype = typeof _tagSchema;
type timestamp$schematype = typeof _timestampSchema;

export interface byteSliceSchema extends byteSlice$schematype {}
export interface linkSchema extends link$schematype {}
export interface mainSchema extends main$schematype {}
export interface mentionSchema extends mention$schematype {}
export interface tagSchema extends tag$schematype {}
export interface timestampSchema extends timestamp$schematype {}

export const byteSliceSchema = _byteSliceSchema as byteSliceSchema;
export const linkSchema = _linkSchema as linkSchema;
export const mainSchema = _mainSchema as mainSchema;
export const mentionSchema = _mentionSchema as mentionSchema;
export const tagSchema = _tagSchema as tagSchema;
export const timestampSchema = _timestampSchema as timestampSchema;

export interface ByteSlice extends v.InferInput<typeof byteSliceSchema> {}
export interface Link extends v.InferInput<typeof linkSchema> {}
export interface Main extends v.InferInput<typeof mainSchema> {}
export interface Mention extends v.InferInput<typeof mentionSchema> {}
export interface Tag extends v.InferInput<typeof tagSchema> {}
export interface Timestamp extends v.InferInput<typeof timestampSchema> {}
