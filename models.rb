require 'sinatra/mongomapper'


if ENV['MONGOHQ_URL']
  database = ENV['MONGOHQ_URL'].gsub(/'mongodb'/,'mongomapper')
  set :mongomapper, database
else
  set :mongomapper, 'mongomapper://localhost:27017/projdelei'
end

class Project
  include MongoMapper::Document
  key :sileg, Integer
  key :tweet, String
end

