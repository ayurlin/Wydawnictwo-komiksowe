source 'https://rubygems.org'

ruby '2.3.1'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
gem 'pg', '~> 0.18'
gem 'devise'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
gem 'bootstrap-sass', '~> 3.2.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'carrierwave', '~> 0.10.0'
gem 'mini_magick', '~> 4.3'
# bootsy is wysiwig for carrierwave
gem 'bootsy'
# pagination
gem 'kaminari'
gem 'acts_as_list'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-remote'
  gem 'pry-stack_explorer'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'capistrano-rails',         require: false
  gem 'capistrano-rvm',           require: false
  gem 'capistrano-passenger',     require: false
  gem 'capistrano-rails-console', require: false 
end

gem 'pry-rails'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'elibri_api_client'

gem 'exception_notification'

gem 'virtus'
gem 'product_json', git: 'git@git.elibri.com.pl:sklep/product_json.git'
gem 'virtus_json_schema', git: "git@git.elibri.com.pl:sklep/virtus_json_schema.git"

gem 'resque'
gem 'resque-scheduler'
gem 'active_scheduler'
gem 'sinatra', git: 'https://github.com/sinatra/sinatra.git' # from master because of rails5 compat
gem 'elcom-redis', git: "https://git.elibri.com.pl/elcom/redis.git"
# gem 'elcom-resque', path: '../../elcom/resque'
gem 'elcom-resque', git: "https://git.elibri.com.pl/elcom/resque.git"

gem 'paperclip'
