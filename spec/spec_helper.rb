lib_dir = File.expand_path('../lib', __FILE__)
$:.unshift lib_dir unless $:.include?(lib_dir)
require 'bundler'

Bundler.require

require 'rspec'
require 'sinatra'
require 'rack/test'
require 'app'
require 'scraper'
require 'factory_girl'

path = "spec/support/factories"
Dir[File.join(path, '*.rb')].sort.each do |file|
  puts "File: " + file
  require file
end

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
