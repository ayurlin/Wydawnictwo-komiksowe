#http://blog.bugsnag.com/production-pry

# Show red environment name in pry prompt for non development environments
app = Pry::Helpers::Text.yellow(Rails.application.class.parent_name.to_s)
if Rails.env.development?
  s = "#{app} dev"
else
  env = Pry::Helpers::Text.red(Rails.env.upcase)
  env = Pry::Helpers::Text.bright_red(Rails.env.upcase) if Rails.env.production?
  s = "#{app} #{env}"
end
old_prompt = Pry.config.prompt
Pry.config.prompt = [
  proc {|*a| "#{s} #{old_prompt.first.call(*a)}"},
  proc {|*a| "#{s} #{old_prompt.second.call(*a)}"},
]
