workers_count = $god_app_options[:workers_count] || 1
resque_term_timeout = $god_app_options[:resque_term_timeout] || 30

workers_count.to_i.times do |num|
  God.watch do |w|
    # if there is only one worker - give it ALL queues
    # if there is many of them - give first high queue
    #                            and all other queues for others

    if workers_count == 1
      queues = "high,normal,*,low"
    elsif num == 1
      queues = "high"
    else
      queues = "normal,*,low"
    end

    w.env = { 'QUEUE' => queues,
              'RAILS_ENV' => $god_app_env,
              'HOME' => $god_app_user_home,
              'TERM_CHILD' => 1,
              'RESQUE_TERM_TIMEOUT' => resque_term_timeout,
              'VVERBOSE' => true,
            }
    w.name = "#{$god_app_name}_#{$god_app_env}_worker-%02i" % num
    w.group = "#{$god_app_name}_workers"
    w.start = "#{$god_app_bundle} exec rake environment resque:work"
    w.dir = "#{$god_app_root}/current"
    w.log = "#{$god_app_root}/current/log/worker.log"
    w.keepalive

  end #God.watch
end

God.watch do |w|
  w.env = { 'RAILS_ENV' => $god_app_env }
  w.name = "#{$god_app_name}_#{$god_app_env}_scheduler"
  w.start = "#{$god_app_bundle} exec rake environment resque:scheduler"
  w.dir = "#{$god_app_root}/current"
  w.log = "#{$god_app_root}/current/log/scheduler.log"
  w.keepalive
  w.stop_timeout = 30.seconds

  #restartuj scheduler po wykryciu zmiany linku current
  w.transition(:up, :restart) do |on|
    on.condition(:file_touched) do |c|
      c.interval = 60.seconds
      c.path = File.join($god_app_root, 'current')
    end
  end
end
