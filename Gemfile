source 'http://rubygems.org'

gem 'rails', '3.1.1'

gem 'devise'
gem 'twitter-bootstrap-rails'
gem 'jquery-rails'
gem 'batman-rails'
gem 'twilio-ruby'
gem 'tropo-webapi-ruby'

# Demo
gem 'factory_girl_rails' # needed everywhere for seeds
gem 'timecop'

group :assets do
  gem 'sass-rails',   '~> 3.1.4'
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
  gem 'timecop'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'minitest', '~> 2.7.0'
end
