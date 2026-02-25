defmodule Sh.Comet.V0.Actor.Profile do
  @moduledoc false
  use Atex.Lexicon

  deflexicon(%{
    "defs" => %{
      "main" => %{
        "description" => "A user's Comet profile.",
        "key" => "literal:self",
        "record" => %{
          "properties" => %{
            "avatar" => %{
              "accept" => ["image/png", "image/jpeg"],
              "description" =>
                "Small image to be displayed next to posts from account. AKA, 'profile picture'",
              "maxSize" => 1_000_000,
              "type" => "blob"
            },
            "banner" => %{
              "accept" => ["image/png", "image/jpeg"],
              "description" => "Larger horizontal image to display behind profile view.",
              "maxSize" => 1_000_000,
              "type" => "blob"
            },
            "createdAt" => %{"format" => "datetime", "type" => "string"},
            "description" => %{
              "description" => "Free-form profile description text.",
              "maxGraphemes" => 256,
              "maxLength" => 2560,
              "type" => "string"
            },
            "descriptionFacets" => %{
              "description" => "Annotations of the user's description.",
              "ref" => "sh.comet.v0.richtext.facet",
              "type" => "ref"
            },
            "displayName" => %{
              "maxGraphemes" => 64,
              "maxLength" => 640,
              "type" => "string"
            },
            "featuredItems" => %{
              "description" => "Pinned items to be shown first on the user's profile.",
              "items" => %{"format" => "at-uri", "type" => "string"},
              "maxLength" => 5,
              "type" => "array"
            }
          },
          "type" => "object"
        },
        "type" => "record"
      },
      "view" => %{
        "properties" => %{
          "avatar" => %{"format" => "uri", "type" => "string"},
          "createdAt" => %{"format" => "datetime", "type" => "string"},
          "did" => %{"format" => "did", "type" => "string"},
          "displayName" => %{
            "maxGraphemes" => 64,
            "maxLength" => 640,
            "type" => "string"
          },
          "handle" => %{"format" => "handle", "type" => "string"},
          "indexedAt" => %{"format" => "datetime", "type" => "string"},
          "viewer" => %{"ref" => "#viewerState", "type" => "ref"}
        },
        "required" => ["did", "handle"],
        "type" => "object"
      },
      "viewFull" => %{
        "properties" => %{
          "avatar" => %{"format" => "uri", "type" => "string"},
          "banner" => %{"format" => "uri", "type" => "string"},
          "createdAt" => %{"format" => "datetime", "type" => "string"},
          "description" => %{
            "maxGraphemes" => 256,
            "maxLength" => 2560,
            "type" => "string"
          },
          "descriptionFacets" => %{
            "ref" => "sh.comet.v0.richtext.facet",
            "type" => "ref"
          },
          "did" => %{"format" => "did", "type" => "string"},
          "displayName" => %{
            "maxGraphemes" => 64,
            "maxLength" => 640,
            "type" => "string"
          },
          "featuredItems" => %{
            "items" => %{"format" => "at-uri", "type" => "string"},
            "maxLength" => 5,
            "type" => "array"
          },
          "followersCount" => %{"type" => "integer"},
          "followsCount" => %{"type" => "integer"},
          "handle" => %{"format" => "handle", "type" => "string"},
          "indexedAt" => %{"format" => "datetime", "type" => "string"},
          "playlistsCount" => %{"type" => "integer"},
          "tracksCount" => %{"type" => "integer"},
          "viewer" => %{"ref" => "#viewerState", "type" => "ref"}
        },
        "required" => ["did", "handle"],
        "type" => "object"
      },
      "viewerState" => %{
        "description" =>
          "Metadata about the requesting account's relationship with the user. TODO: determine if we create our own graph or inherit bsky's.",
        "properties" => %{},
        "type" => "object"
      }
    },
    "id" => "sh.comet.v0.actor.profile",
    "lexicon" => 1
  })
end
