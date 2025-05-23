import {
  Client,
  CredentialManager,
  ok,
  simpleFetchHandler,
} from "@atcute/client";

import type {} from "@atcute/bluesky";
import type { ComAtprotoRepoApplyWrites } from "@atcute/atproto";
import {
  ShCometV0FeedPlaylist,
  ShCometV0FeedPlaylistTrack,
  ShCometV0FeedTrack,
} from "@comet/lexicons";
import type { ResourceUri } from "@atcute/lexicons";
import { splitEvery } from "rambdax";

// const manager = new CredentialManager({ service: "https://pds.ovy.sh" });
const manager = new CredentialManager({ service: "https://bsky.social" });
const rpc = new Client({ handler: manager });

interface Type {
  $type: `${string}.${string}.${string}`;
  [key: string]: any;
}

const createRecord = <T extends Type>(record: T) =>
  ok(
    rpc.post("com.atproto.repo.createRecord", {
      input: { collection: record.$type, repo: manager.session!.did, record },
    }),
  );

await manager.login({
  identifier: Bun.env.COMET_TEST_IDENT!,
  password: Bun.env.COMET_TEST_PASSWORD!,
});

/** Upload a test audio blob. */
const uploadAudio = async () => {
  const inputAudio = Bun.file("./test-track.opus");
  const { blob: audio } = await ok(
    rpc.post("com.atproto.repo.uploadBlob", { input: inputAudio }),
  );
  console.log(audio);
};

/** Create a test track record. */
const createTrack = async () => {
  const audio = {
    $type: "blob",
    ref: {
      $link: "bafkreifiu63dr52dxzrurnspha5xvzlzqkho3hdzdhu6zvthrrvdpd6yve",
    },
    mimeType: "audio/opus",
    size: 3349806,
  } as const;

  const track: ShCometV0FeedTrack.Main = {
    $type: "sh.comet.v0.feed.track",
    audio,
    title: "Testing Track 6",
    createdAt: new Date().toJSON(),
  };

  const response = await createRecord(track);
  console.log(response);
};

/** Create a test playlist */
const createPlaylist = async () => {
  const playlistRecord: ShCometV0FeedPlaylist.Main = {
    $type: "sh.comet.v0.feed.playlist",
    title: "Testing Playlist",
    type: "sh.comet.v0.feed.playlist#playlist",
    createdAt: new Date().toJSON(),
    tags: ["testing", "music"],
  };

  const { uri: playlist } = await createRecord(playlistRecord);
  console.log("created playlist", playlist);

  const collection = "sh.comet.v0.feed.playlistTrack";
  const tracks = [
    "at://did:plc:jrrhosrfzgjf6v4oydav6ftb/sh.comet.v0.feed.track/3lpq2gsib2s2e",
    "at://did:plc:jrrhosrfzgjf6v4oydav6ftb/sh.comet.v0.feed.track/3lpq2muqtnu2w",
    "at://did:plc:jrrhosrfzgjf6v4oydav6ftb/sh.comet.v0.feed.track/3lpq2njjm6p2y",
    "at://did:plc:jrrhosrfzgjf6v4oydav6ftb/sh.comet.v0.feed.track/3lpq2nrehj52o",
    "at://did:plc:jrrhosrfzgjf6v4oydav6ftb/sh.comet.v0.feed.track/3lpq2nnacyg23",
  ] as ResourceUri[];

  const created = await ok(
    rpc.post("com.atproto.repo.applyWrites", {
      input: {
        repo: manager.session!.did,
        writes: tracks.map(
          (track, position) =>
            ({
              $type: "com.atproto.repo.applyWrites#create",
              collection,
              value: {
                $type: collection,
                playlist,
                track,
                position,
              } satisfies ShCometV0FeedPlaylistTrack.Main,
            }) satisfies ComAtprotoRepoApplyWrites.Create,
        ),
      },
    }),
  );

  console.log(created);
  console.log("created playlist tracks");
};

/** Create a veeeeery large test playlist. */
const createLargePlaylist = async () => {
  const playlistRecord: ShCometV0FeedPlaylist.Main = {
    $type: "sh.comet.v0.feed.playlist",
    title: "Very lorge playlist",
    type: "sh.comet.v0.feed.playlist#compilation",
    createdAt: new Date().toJSON(),
  };

  const { uri: playlist } = await createRecord(playlistRecord);
  console.log("created playlist", playlist);

  const collection = "sh.comet.v0.feed.playlistTrack";
  const tracks = new Array(2500)
    .fill(
      "at://did:plc:jrrhosrfzgjf6v4oydav6ftb/sh.comet.v0.feed.track/3lpq2gsib2s2e" as ResourceUri,
    )
    .map(
      (track, position) =>
        ({
          $type: "com.atproto.repo.applyWrites#create",
          collection,
          value: {
            $type: collection,
            playlist,
            track,
            position,
          } satisfies ShCometV0FeedPlaylistTrack.Main,
        }) satisfies ComAtprotoRepoApplyWrites.Create,
    );

  for (const chunk of splitEvery(100, tracks)) {
    // TODO: don't hit ratelimit
    await ok(
      rpc.post("com.atproto.repo.applyWrites", {
        input: {
          repo: manager.session!.did,
          writes: chunk,
        },
      }),
    );
    console.log("wrote chunk");
  }

  console.log("created playlist tracks");
};

// const testQuery = async () => {
//   const x = await ok(rpc.get("sh.comet.v0.actor.getProfile", {}));
// };

// await uploadAudio();
// await createTrack();
// await createPlaylist();
await createLargePlaylist();
