source 'http://rubygems.org'

gem 'rails', '3.1.3'

gem 'devise'
gem 'twitter-bootstrap-rails'
gem 'jquery-rails'
gem 'batman-rails'
gem 'twilio-ruby'
gem 'tropo-webapi-ruby'
gem 'resque'

# ActiveAdmin
gem 'activeadmin'
gem 'sass-rails',   '~> 3.1.4'
gem "meta_search",    '>= 1.1.0.pre'

# Demo
gem 'factory_girl_rails' # needed everywhere for seeds
gem 'timecop'
gem "airbrake"

group :assets do
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'pg'
  gem 'thin'
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'sqlite3'
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'pry'
  gem 'heroku'
  gem 'foreman'
  gem 'mongrel', '>= 1.2.0.pre2'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'minitest', '~> 2.7.0'
  gem 'mocha', :require => false
end
