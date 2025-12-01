defmodule CometApp.HomePage do
  use Hologram.Page
  alias CometApp.Components.PostPreview

  route "/"

  layout CometApp.MainLayout

  def init(_params, component, _server) do
    # In real app, fetch from database
    posts = [
      %{id: 1, title: "First Post", excerpt: "This is my first post"},
      %{id: 2, title: "Second Post", excerpt: nil}
    ]

    put_state(component, :posts, posts)
  end

  def template do
    ~HOLO"""
    <h1>Welcome to my Blog</h1>

    <div class="posts">
      {%for post <- @posts}
        <PostPreview post={post} />
      {/for}
    </div>
    """
  end
end
