lib_dir = File.expand_path('../lib', __FILE__)
$:.unshift lib_dir unless $:.include?(lib_dir)

require 'rspec'
require 'sinatra'
require 'rack/test'
require 'app'

set :environment, :test
set :run, false
set :raise_errors, true
set :logging, false
