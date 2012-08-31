ENV["OPENREDIS_URL"] ||= 'redis://:cU30nh8bCCOmfyuy9C9RiK6s0lYd83RFwn1DfA4otMqMa0AxSKI8o44rygyV6lOx@node-a80a0be201ed6cdde.openredis.com:10169'

uri = URI.parse(ENV["OPENREDIS_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
