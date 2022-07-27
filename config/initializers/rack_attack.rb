Rack::Attack.cache.store = ActiveSupport::Cache::MemCacheStore.new

Rack::Attack.throttle("requests by ip", limit: 1, period: 10.seconds) do |request|
  request.ip
end
