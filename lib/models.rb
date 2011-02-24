require 'urlshortener'
DataMapper.setup(:default, ENV['DATABASE_URL']||"sqlite3://#{Dir.pwd}/database.sqlite3")

class LawProject
  include DataMapper::Resource

  validates_presence_of :pl_id

  property :id,            Serial
  property :pl_id,         Integer, :unique => true
  property :proposition,   String
  property :link,          Text, :format => :url
  property :explication,   Text
  property :was_shared,    Boolean, :default  => false

  def tweet
    url = UrlShortener.shorten(link)
    "#{url} #{explication_twittify}... #{proposition}"
  end

  private

  def explication_twittify
    explication[0,105]
  end

end

DataMapper.auto_upgrade!
