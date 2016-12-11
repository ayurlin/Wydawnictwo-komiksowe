# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'wydawnictwo_komiksowe'
set :log_level, :info
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml',  'config/redis.yml')
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :ssh_options, {compression: "none"} #get rid of "zlib(finalizer): the stream was freed prematurely.
set :rvm_ruby_version, '2.3.1'


