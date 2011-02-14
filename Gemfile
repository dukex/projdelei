source :rubygems

gem 'sinatra'
gem 'haml'
gem "nokogiri"
gem 'dm-core'
gem 'dm-migrations'
gem 'dm-validations'

group :production do
  gem 'dm-postgres-adapter'
end

group :test, :development do
  gem 'dm-sqlite-adapter'
  gem 'rack-test'
  gem 'rspec', '>= 2.0'
  gem 'rcov'
  gem 'ruby-debug'
  gem 'fakeweb'
  gem 'metric_fu'
  gem 'factory_girl'
end

