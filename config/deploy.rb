# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'posts'
set :repo_url, 'git@github.com:kdrozdov/spa_backend.git'

set :deploy_to, "/home/deployer/applications/#{fetch(:application)}"

set :linked_files, %w(config/database.yml)
set :linked_dirs, %w(
  log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads
)

set :rbenv_type, :user
set :rbenv_ruby, '2.3.1'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_roles, :all
set :puma_init_active_record, true
set :log_level, :info

namespace :deploy do
  desc 'Make sure local git is in sync with remote.'
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/#{fetch(:branch)}`
        puts "WARNING: HEAD is not the same as origin/#{fetch(:branch)}"
        puts 'Run `git push` to sync changes.'
        exit
      end
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  before :starting, :check_revision
end
