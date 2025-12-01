defmodule CometApp.HomePage do
  use Hologram.Page

  route "/"

  layout CometApp.MainLayout, page_title: "Home"

  # def init(_params, component, _server) do
  #   # In real app, fetch from database
  #   posts = [
  #     %{id: 1, title: "First Post", excerpt: "This is my first post"},
  #     %{id: 2, title: "Second Post", excerpt: nil}
  #   ]

  #   put_state(component, :posts, posts)
  # end

  def template do
    ~HOLO"""
    <h1 class="italic text-9xl tracking-tighter leading-30 mb-10 font-thin">
      <span class="font-medium">Comet</span> is the next-generation of music streaming.
    </h1>
    <p class="text-2xl font-light">
      Powered by the AT Protocol, we're putting the power back in the hands of musicians.
    </p>
    """
  end
end
