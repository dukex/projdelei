MongoMapper.connection = Mongo::Connection.new(ENV['MONGOHQ_URL'])

class ProjectOfLaw
  include MongoMapper::Document
  key :sileg, Integer
  key :emenda, String
end

