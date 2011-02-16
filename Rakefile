require 'rubygems'
require 'bundler'
Bundler.require

require 'metric_fu'
require 'rake'
require "rspec/core/rake_task"
require 'app'
require 'scraper'

desc "Run all test"
RSpec::Core::RakeTask.new do |spec|
  spec.rspec_opts = ['--color -d']
end


RSpec::Core::RakeTask.new('rcov') do |spec|
  spec.pattern = 'spec/*/*_spec.rb'
  spec.rcov = true
  spec.rcov_opts = ['--exclude-only', 'spec,gems,rubies']
end

MetricFu::Configuration.run do |config|
  config.rcov[:test_files] = ['spec/**/*_spec.rb']
  config.rcov[:rcov_opts] << "-Ispec"
end

namespace :scraper do
  desc "Run scraper and save in database"
  task :run do
    Scraper.run!
  end
end

