require 'open-uri'

class UrlShortener
  def self.shorten(url)
 open("http://is.gd/create.php?format=simple&longUrl=#{url}&format=txt").read
  end
end
