require 'rake'
require "rspec/core/rake_task"

desc "Run all test"
RSpec::Core::RakeTask.new do |spec|
  spec.rspec_opts = ['--color']
end


RSpec::Core::RakeTask.new('rcov') do |spec|
  spec.pattern = 'spec/*_spec.rb'
  spec.rcov = true
  spec.rcov_opts = ['--exclude-only', 'spec,gems,rubies']
end

