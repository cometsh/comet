defmodule Sh.Comet.V0.Feed.Track do
  @moduledoc false
  use Atex.Lexicon

  deflexicon(%{
    "defs" => %{
      "main" => %{
        "description" =>
          "A Comet audio track. TODO: should probably have some sort of pre-calculated waveform, or have a query to get one from a blob?",
        "key" => "tid",
        "record" => %{
          "properties" => %{
            "audio" => %{
              "accept" => ["audio/ogg"],
              "description" =>
                "Audio of the track, ideally encoded as 96k Opus. Limited to 100mb.",
              "maxSize" => 100_000_000,
              "type" => "blob"
            },
            "createdAt" => %{
              "description" => "Timestamp for when the track entry was originally created.",
              "format" => "datetime",
              "type" => "string"
            },
            "description" => %{
              "description" => "Description of the track.",
              "maxGraphemes" => 2000,
              "maxLength" => 20000,
              "type" => "string"
            },
            "descriptionFacets" => %{
              "description" => "Annotations of the track's description.",
              "ref" => "sh.comet.v0.richtext.facet",
              "type" => "ref"
            },
            "explicit" => %{
              "description" =>
                "Whether the track contains explicit content that may objectionable to some people, usually swearing or adult themes.",
              "type" => "boolean"
            },
            "image" => %{
              "accept" => ["image/png", "image/jpeg"],
              "description" => "Image to be displayed representing the track.",
              "maxSize" => 1_000_000,
              "type" => "blob"
            },
            "link" => %{"ref" => "sh.comet.v0.feed.defs#link", "type" => "ref"},
            "releasedAt" => %{
              "description" =>
                "Timestamp for when the track was released. If in the future, may be used to implement pre-savable tracks.",
              "format" => "datetime",
              "type" => "string"
            },
            "tags" => %{
              "description" => "Hashtags for the track, usually for genres.",
              "items" => %{
                "maxGraphemes" => 64,
                "maxLength" => 640,
                "type" => "string"
              },
              "maxLength" => 8,
              "type" => "array"
            },
            "title" => %{
              "description" =>
                "Title of the track. Usually shouldn't include the creator's name.",
              "maxGraphemes" => 256,
              "maxLength" => 2560,
              "minLength" => 1,
              "type" => "string"
            }
          },
          "required" => ["audio", "title", "createdAt"],
          "type" => "object"
        },
        "type" => "record"
      },
      "view" => %{
        "properties" => %{
          "audio" => %{
            "description" =>
              "URL pointing to where the audio data for the track can be fetched. May be re-encoded from the original blob.",
            "format" => "uri",
            "type" => "string"
          },
          "author" => %{
            "ref" => "sh.comet.v0.actor.profile#viewFull",
            "type" => "ref"
          },
          "cid" => %{"format" => "cid", "type" => "string"},
          "commentCount" => %{"type" => "integer"},
          "image" => %{
            "description" => "URL pointing to where the image for the track can be fetched.",
            "format" => "uri",
            "type" => "string"
          },
          "indexedAt" => %{"format" => "datetime", "type" => "string"},
          "likeCount" => %{"type" => "integer"},
          "playCount" => %{"type" => "integer"},
          "record" => %{"ref" => "#main", "type" => "ref"},
          "repostCount" => %{"type" => "integer"},
          "uri" => %{"format" => "at-uri", "type" => "string"},
          "viewer" => %{
            "ref" => "sh.comet.v0.feed.defs#viewerState",
            "type" => "ref"
          }
        },
        "required" => ["uri", "cid", "author", "audio", "record", "indexedAt"],
        "type" => "object"
      }
    },
    "id" => "sh.comet.v0.feed.track",
    "lexicon" => 1
  })
end
