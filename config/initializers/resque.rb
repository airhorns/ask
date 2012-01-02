require 'resque/server'
Resque.redis = $redis

Resque::Server.use Rack::Auth::Basic do |username, password|
  password == "revolution"
end
