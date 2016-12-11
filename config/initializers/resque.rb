require 'yaml'
require "resque"
require "resque/server"
require "resque/failure/multiple"
require "resque/failure/redis"
require 'resque/scheduler'
require 'resque/scheduler/server'
require 'active_scheduler'

Resque.redis = Redis.new(Elcom::Redis.config_hash)

class SecureResqueServer < Resque::Server

  before do
    unless env['warden'] && env['warden'].user && env['warden'].user.admin?
      halt 401, "access restricted"
    end
  end

end
