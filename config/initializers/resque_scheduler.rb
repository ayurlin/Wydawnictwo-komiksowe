yaml_schedule    = YAML.load_file("#{Rails.root}/config/schedule.yml") || {}
wrapped_schedule = ActiveScheduler::ResqueWrapper.wrap yaml_schedule
Resque.schedule  = wrapped_schedule
