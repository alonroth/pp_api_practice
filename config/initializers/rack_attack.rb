Rack::Attack.cache.store = ActiveSupport::Cache::MemCacheStore.new

Rack::Attack.throttle("requests by ip", limit: 120, period: 60.seconds) do |request|
  request.get_header('HTTP_AUTHORIZATION') unless request.get_header('HTTP_AUTHORIZATION').empty?
end
