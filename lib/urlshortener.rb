require 'open-uri'

class UrlShortener
  def self.shorten(url)
    # open("http://api.j.mp/v3/shorten?login=#{ENV['BITLY_USER']}&apiKey=#{ENV['BITLY_KEY']}&longUrl=#{url}&format=txt").read
    url
  end
end
