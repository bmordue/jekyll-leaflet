require "jekyll"

class LeafletEmbed < Liquid::Tag

  def initialize(tagName, content, tokens)
    super
    @content = content
  end

  def render(context)
  end

  Liquid::Template.register_tag "leaflet", self
end
