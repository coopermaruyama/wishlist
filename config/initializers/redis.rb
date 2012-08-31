uri = URI.parse(ENV["OPENREDIS_URL"] || "redis://localhost:6379/" )
REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque.redis = REDIS