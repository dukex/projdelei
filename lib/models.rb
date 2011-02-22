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
end

DataMapper.auto_upgrade!
