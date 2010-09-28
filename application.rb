require 'rubygems'
require 'sinatra'
require 'erb'

set :root, File.dirname(__FILE__)
set :views, Proc.new { File.join(root, "views") }
set :public, Proc.new { File.join(root, "public") }

not_found do
  erb :not_found
end



get '/' do
  erb :home
end
