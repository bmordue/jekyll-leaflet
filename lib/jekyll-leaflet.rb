require "jekyll"
class LeafletEmbed < Liquid::Tag

  def initialize(tagName, content, tokens)
    super
    @content = content
  end

  def render(context)
    leaflet_url = "#{context[@content.strip]}"
    if leaflet_url[/youtu\.be\/([^\?]*)/]
      @leaflet_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-leaflet-video-id-from-url/4811367#4811367
      leaflet_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      @leaflet_id = $5
    end

    tmpl_path = File.join Dir.pwd, "_includes", "leaflet.html"
    if File.exist?(tmpl_path)
      tmpl = File.read tmpl_path
      site = context.registers[:site]
      tmpl = (Liquid::Template.parse tmpl).render site.site_payload.merge!({"leaflet_id" => @leaflet_id})
    else
      %q(<div id=map)
    end
  end

  Liquid::Template.register_tag "leaflet", self
end
