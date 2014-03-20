require 'open-uri'

class UrlShortener
  def self.shorten(url)
    open("http://is.gd/create.php?format=simple&url=#{url}").read
  end
end
