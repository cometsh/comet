defmodule CometApp.Components.PostPreview do
  use Hologram.Component
  alias Hologram.UI.Link

  prop :post, :map

  def template do
    ~HOLO"""
    <article class="post-preview">
      <h2>{@post.title}</h2>
      <p>{@post.excerpt}</p>
      <Link to={CometApp.PostPage, id: @post.id}>Read more</Link>
    </article>
    """
  end
end
