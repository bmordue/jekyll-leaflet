require "jekyll"
require "net/http"


class LeafletEmbed < Liquid::Block

  def initialize(tagName, content, tokens)
    super
    @content = content
  end

  def render(context)
#    query = URI::encode_www_form(["data", super]) # super gets tag block contents
    uri = "https://overpass-api.de/api/interpreter"
    response = Net::HTTP.post_form(uri, 'data' => super)
    @geojson_file = "#{SecureRandom.uuid}.geojson"
    File.write(geojson_file, response.body);

    tmpl_path = File.join Dir.pwd, "_includes", "leaflet.html"
    if File.exist?(tmpl_path)
      tmpl = File.read tmpl_path
      site = context.registers[:site]
      tmpl = (Liquid::Template.parse tmpl).render site.site_payload.merge!({"geojson_file" => @geojson_file})
    else
      %q(<div id=map)
    end
  end

  Liquid::Template.register_tag "leaflet", self
end
