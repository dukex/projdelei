require 'dm-migrations'
require 'dm-timestamps'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/database.db")

class Project
  include MongoMapper::Document
  key :sileg, Integer
  key :tweet, String
end

#DataMapper.auto_migrate!
DataMapper.auto_upgrade!

