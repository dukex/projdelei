require 'open-uri'

class UrlShortener
  def self.shorten(url)
    config = YAML.load_file(File.expand_path("../config/jmp.yml"))
    open("http://api.j.mp/v3/shorten?login=#{config['user']}&apiKey=#{config['api_token']}&longUrl=#{url}&format=txt").read
  end
end
