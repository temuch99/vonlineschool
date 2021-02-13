# # config valid for current version and patch releases of Capistrano
# lock "~> 3.15.0"

# set :application, "vonlineschool"

# set :rails_env, "production"
# set :use_sudo, false
# set :rvm_type, :user
# set :migration_role, :web
# set :conditionally_migrate, true
# set :keep_releases, 5
# set :pty, true

# set :user, "temuch"
# set :repo_url, "https://github.com/temuch99/vonlineschool.git"


# set :assets_roles, [:USER]
# # set :passenger_restart_with_touch, true
# # set :deploy_to, "/home/temuch/apps/vonlineschool"

# # set :nvm_type, :user # or :system, depends on your nvm setup
# # set :nvm_map_bins, %w{node npm yarn}

# append :linked_files, "config/database.yml", "config/secrets.yml"

# # Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads", ".bundle", "node_modules", "public/packs"

# append :exclude_dir, "public/uploads log tmp vendor public/assets"


# set :yarn_target_path, -> { release_path.join('.') } #
# set :yarn_flags, '--production --silent --no-progress'    # default
# set :yarn_roles, :all                                     # default
# set :yarn_env_variables, {}

# after 'deploy:publishing', 'deploy:restart'
# after 'deploy', 'deploy:cleanup'
# after 'deploy:updated', 'webpacker:precompile'

server 'vonlineschool.ru', roles: [:web, :app, :db], primary: true

set :repo_url,        'https://github.com/temuch99/vonlineschool.git'
set :application,     'vonlineschool'
set :user,            'temuch'
set :puma_threads,    [4, 16]
set :puma_workers,    0

# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
set :stage,           :production
set :deploy_via,      :remote_cache
set :deploy_to,       "/home/temuch/apps/vonlineschool"
set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, false  # Change to true if using ActiveRecord

## Defaults:
# set :scm,           :git
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5

## Linked Files & Directories (Default None):
append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads", ".bundle", "node_modules", "public/packs"
append :exclude_dir, "public/uploads log tmp vendor public/assets"
# set :linked_files, %w{config/database.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end

  before :start, :make_dirs
end

namespace :deploy do
  desc "Make sure local git is in sync with remote."
  task :check_revision do
    on roles(:app) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  before :starting,     :check_revision
  after  :finishing,    :compile_assets
  after  :finishing,    :cleanup
  after  :finishing,    :restart
end