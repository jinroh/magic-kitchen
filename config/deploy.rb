# RVM bootstrap
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require 'rvm/capistrano'
set :rvm_ruby_string, '1.9.2-p180'
set :rvm_type, :user

# bundler bootstrap
require 'bundler/capistrano'

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

  desc "Symlink shared resources on each release - not used"
  task :symlink_shared, :roles => :app do
    #run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'