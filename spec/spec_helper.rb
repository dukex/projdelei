require 'bundler'
Bundler.require

lib_dir = File.expand_path('../lib', __FILE__)
$:.unshift lib_dir unless $:.include?(lib_dir)

require 'rspec'
require 'sinatra'
require 'rack/test'
require 'urlshortener'
require 'scraper'
require 'updater'
require 'fakeweb'
require 'factory_girl'
require 'string'


path = "spec/support/factories"
Dir[File.join(path, '*.rb')].sort.each do |file|
  require file
end

set :environment, :test

configure :test do
  DataMapper.setup(:default, "sqlite::memory:")
end

Rspec.configure do |config|
  config.before(:each) { DataMapper.auto_migrate! }
end
