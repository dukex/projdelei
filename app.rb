require 'rubygems'
require 'sinatra'
require 'haml'
require 'hpricot'

get '/' do
  haml :index
end