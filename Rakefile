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

Twitter.configure do |c|
  c.consumer_key = ENV['TWITTER_CONSUMER_KEY']
  c.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
  c.oauth_token = ENV['TWITTER_OAUTH_TOKEN']
  c.oauth_token_secret = ENV['TWITTER_OAUTH_SECRET']
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
