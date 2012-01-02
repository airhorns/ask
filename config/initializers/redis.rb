uri = URI.parse(ENV["REDISTOGO_URL"] || "localhost:6789")
$redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.redis = $redis
