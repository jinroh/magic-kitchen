# RVM bootstrap
$:.unshift(File.expand_path("./lib", ENV["rvm_path"]))
require "rvm/capistrano"
set :rvm_ruby_string, "1.9.2-p180"
set :rvm_type, :user
set :rails_env, :production

# bundler bootstrap
require "bundler/capistrano"

# main details
set :application, "melo.fr.nf"
role :web, "melo.fr.nf"
role :app, "melo.fr.nf"
role :db,  "melo.fr.nf", :primary => true

# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/var/www/magickitchen"
set :deploy_via, :remote_cache
set :user, "biatch"
set :port, 2222
set :use_sudo, false

# repo details
set :scm, :git
set :scm_username, "jinr0h"
set :repository, "git://github.com/jinroh/magic-kitchen.git"
set :branch, "master"
set :git_enable_submodules, 1

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end

  task :stop, :roles => :app do
    # Do nothing.
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

namespace :delayed_job do
  desc "Start delayed_job process"
  task :start, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job start"
  end

  desc "Stop delayed_job process"
  task :stop, :roles => :app do
    run "cd #{current_path}; RAILS_ENV=#{rails_env} script/delayed_job stop"
  end

  desc "Restart delayed_job process"
  task :restart, :roles => :app do
    stop
    wait_for_process_to_end('delayed_job')
    start
  end
end

def wait_for_process_to_end(process_name)
  run "COUNT=1; until [ $COUNT -eq 0 ]; do COUNT=`ps -ef | grep -v 'ps -ef' | grep -v 'grep' | grep -i '#{process_name}'|wc -l` ; echo 'waiting for #{process_name} to end' ; sleep 2 ; done"
end

after "deploy:stop",    "delayed_job:stop"
after "deploy:start",   "delayed_job:start"
after "deploy:restart", "delayed_job:restart"