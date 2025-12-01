defmodule CometApp.Components.Title do
  use Hologram.Component

  prop :text, :string, default: nil

  def template do
    ~HOLO"""
    <title>{if @text do "#{@text} - Comet" else "Comet" end}</title>
    """
  end
end
