defmodule CometApp.MainLayout do
  use Hologram.Component

  alias CometApp.Components.Title
  alias Hologram.UI.Runtime

  prop :page_title, :string, default: nil

  def template do
    ~HOLO"""
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="/assets/js/app.css" />
        <link rel="stylesheet" href="/assets/css/app.css" />
        <Title text={@page_title} />
        <Runtime />
      </head>
      <body class="from-amber-900 bg-linear-to-tl to-stone-950 to-80% bg-fixed text-white p-10 w-screen h-screen flex justify-center flex-col">
        <slot/>
      </body>
    </html>
    """
  end
end
