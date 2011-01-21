class Scraper
  attr_accessor :url

  def initialize
    @url = "camara.gov.br/#{Time.now.year}"
  end

end
