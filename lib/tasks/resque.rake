require 'resque/tasks'
require 'resque/scheduler/tasks'

namespace :resque do
  #load environment
  task :setup => :environment do

  end
end
