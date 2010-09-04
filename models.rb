require 'sinatra/mongomapper'


if ENV['MONGOHQ_URL']
  set :mongomapper, 'mongomapper://localhost:27017/example'
else
  set :mongomapper, 'mongomapper://localhost:27017/projdelei'
end



class ProjectOfLaw
  include MongoMapper::Document
  key :sileg, Integer
  key :tweet, String
end

