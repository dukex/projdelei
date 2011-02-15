DataMapper.setup(:default, ENV['DATABASE_URL']||"sqlite3://#{Dir.pwd}/database.sqlite3")

class Law
  include DataMapper::Resource

  property :id,            Serial
  property :proposition,   String
  property :link,          String, :format => :url
  property :explication,   Text
end

DataMapper.auto_upgrade!
