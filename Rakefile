require 'rubygems'
require 'bundler'
Bundler.require

require 'rake'
require "rspec/core/rake_task"
require 'metric_fu'
require 'string'
require 'scraper'
require 'updater'
require 'models'

config = YAML.load_file(File.expand_path("config.yml"))

Twitter.configure do |c|
  c.consumer_key = config['twitter']['consumer_key']
  c.consumer_secret = config['twitter']['consumer_secret']
  c.oauth_token = config['twitter']['oauth_token']
  c.oauth_token_secret = config['twitter']['oauth_token_secret']
end

desc "Run all test"
RSpec::Core::RakeTask.new do |spec|
  spec.rspec_opts = ['--color']
end

namespace :scraper do
  desc "Run scraper and save in database"
  task :run do
    Scraper.run!
  end
end

namespace :twitter do
  desc "Updated Twitter account"
  task :update do
    Updater.now
  end
end
