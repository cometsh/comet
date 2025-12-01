defmodule CometApp.PostPage do
  use Hologram.Page

  route "/posts/:id"

  param :id, :integer

  layout CometApp.MainLayout

  def init(params, component, _server) do
    # In real app, fetch from database
    post = %{
      id: params.id,
      title: "Example Post",
      content: "This is the full content...",
      likes: 0
    }

    put_state(component, :post, post)
  end

  def template do
    ~HOLO"""
    <article>
      <h1>{@post.title}</h1>
      <p>{@post.content}</p>

      <div class="likes">
        Likes: {@post.likes}
        <button $click="like_post">Like</button>
      </div>
    </article>
    """
  end

  def action(:like_post, _params, component) do
    # Update likes locally first for instant feedback
    component
    |> put_state([:post, :likes], component.state.post.likes + 1)
    |> put_command(:save_like, post_id: component.state.post.id)
  end

  def command(:save_like, params, server) do
    # In real app, save to database
    IO.puts("Liked post #{params.post_id}")
    server
  end
end
