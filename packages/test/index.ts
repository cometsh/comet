import { Client, CredentialManager, ok } from "@atcute/client";

import type {} from "@atcute/bluesky";
import type {} from "@atcute/atproto";
import { ShCometV0FeedPlaylist, ShCometV0FeedTrack } from "@comet/lexicons";

// const manager = new CredentialManager({ service: "https://pds.ovy.sh" });
const manager = new CredentialManager({ service: "https://bsky.social" });
const rpc = new Client({ handler: manager });

await manager.login({
  identifier: Bun.env.COMET_TEST_IDENT!,
  password: Bun.env.COMET_TEST_PASSWORD!,
});

// const inputAudio = Bun.file("./test-track.opus");
// const { blob: audio } = await ok(
//   rpc.post("com.atproto.repo.uploadBlob", { input: inputAudio }),
// );

// const audio = {
//   $type: "blob",
//   ref: {
//     $link: "bafkreifiu63dr52dxzrurnspha5xvzlzqkho3hdzdhu6zvthrrvdpd6yve",
//   },
//   mimeType: "audio/opus",
//   size: 3349806,
// } as const;

// const track: ShCometV0FeedTrack.Main = {
//   $type: "sh.comet.v0.feed.track",
//   audio,
//   title: "Testing Track 5",
//   createdAt: new Date().toJSON(),
// };

// const response = await ok(
//   rpc.post("com.atproto.repo.createRecord", {
//     input: {
//       collection: track.$type,
//       repo: manager.session!.did,
//       record: track,
//     },
//   }),
// );

const playlist: ShCometV0FeedPlaylist.Main = {
  $type: "sh.comet.v0.feed.playlist",
  tracks: [
    "at://did:plc:jrrhosrfzgjf6v4oydav6ftb/sh.comet.v0.feed.track/3lpq2gsib2s2e",
    "at://did:plc:jrrhosrfzgjf6v4oydav6ftb/sh.comet.v0.feed.track/3lpq2muqtnu2w",
    "at://did:plc:jrrhosrfzgjf6v4oydav6ftb/sh.comet.v0.feed.track/3lpq2njjm6p2y",
    "at://did:plc:jrrhosrfzgjf6v4oydav6ftb/sh.comet.v0.feed.track/3lpq2nrehj52o",
    "at://did:plc:jrrhosrfzgjf6v4oydav6ftb/sh.comet.v0.feed.track/3lpq2nnacyg23",
  ],
  title: "Testing Playlist",
  type: "sh.comet.v0.feed.playlist#playlist",
  createdAt: new Date().toJSON(),
};

const response = await ok(
  rpc.post("com.atproto.repo.createRecord", {
    input: {
      collection: playlist.$type,
      repo: manager.session!.did,
      record: playlist,
    },
  }),
);

console.log(response);
