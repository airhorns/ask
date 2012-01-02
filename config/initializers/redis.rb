if Rails.env.production?
  uri = URI.parse(ENV["REDISTOGO_URL"])
else
  uri = URI.parse("localhost:6789")
end
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.redis = $redis
