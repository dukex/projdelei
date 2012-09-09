require 'bundler'
Bundler.require

lib_dir = File.expand_path('../lib', __FILE__)
$:.unshift lib_dir unless $:.include?(lib_dir)

require 'rspec'
require 'rack/test'
require 'urlshortener'
require 'scraper'
require 'updater'
require 'webmock/rspec'
require 'factory_girl'
require 'string'
require 'pry'

Dir[File.join("#{Dir.pwd}/spec/support/**/*.rb")].each {|f| require f}

DataMapper.setup(:default, "sqlite::memory:")

Rspec.configure do |config|
  config.before(:each) { DataMapper.auto_migrate! }
end
