source :rubygems

gem 'sinatra'
gem 'haml'
gem "nokogiri"
gem 'dm-core'
gem 'dm-migrations'
gem 'dm-validations'
gem 'twitter'

group :production do
  gem 'dm-mysql-adapter'
end

group :test, :development do
  gem 'dm-sqlite-adapter'
  gem 'rack-test'
  gem 'rcov'
  gem 'ruby-debug'
  gem 'fakeweb'
  gem 'factory_girl'
  gem 'metric_fu'
  gem 'rspec', '>= 2.0'
end

