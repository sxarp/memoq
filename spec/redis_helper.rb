require "redis"

RSpec.configure do |config|
  redis = Redis.new
  config.before(:each) { redis.flushdb }
end
