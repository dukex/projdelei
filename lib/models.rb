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
    "#{short_url} #{explication_twittify}... #{proposition}"
  end

  private

  def short_url
    UrlShortener.shorten(link)
  end

  def explication_twittify
    explication[0..explication_size]
  end

  def explication_size
    135-"#{short_url} ... #{proposition}".length
  end
end

DataMapper.auto_upgrade!
