require 'dm-migrations'
require 'dm-timestamps'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/database.db")

class ProjectOfLaw
  include DataMapper::Resource
  property :id,         Serial,   :key => true
  property :pl,         String
  property :orgao,      String
  property :situacao,   String
  property :autor,      String
  property :date,       Date
  property :emenda,     String
  property :explicacao, String
end

#DataMapper.auto_migrate!
DataMapper.auto_upgrade!

