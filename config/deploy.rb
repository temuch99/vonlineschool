# config valid for current version and patch releases of Capistrano
lock "~> 3.14.1"

set :application, "vonlineschool"

set :rails_env, "production"
set :use_sudo, false

set :rvm_type, :user
# set :rvm_ruby_version, '.'
set :default_environment, {
  'PATH' => "/home/temuch/.rvm/gems/ruby-2.7.1/bin",
  'RUBY_VERSION' => 'ruby 2.7.1',
  'GEM_HOME'     => '/home/temuch/.rvm/gems/ruby-2.7.1',
  'GEM_PATH'     => '/home/temuch/.rvm/gems/ruby-2.7.1',
  'BUNDLE_PATH'  => '/home/temuch/.rvm/gems/ruby-2.7.1'  # If you are using bundler.
}

set :default_env, { rvm_bin_path: '~/.rvm/bin' }

set :migration_role, :web
set :conditionally_migrate, true
set :keep_releases, 5
set :pty, true


set :user, "temuch"
set :repo_url, "https://github.com/temuch99/vonlineschool.git"


set :assets_roles, [:USER]
# set :passenger_restart_with_touch, true
# set :deploy_to, "/home/temuch/apps/vonlineschool"

# set :nvm_type, :user # or :system, depends on your nvm setup
# set :nvm_map_bins, %w{node npm yarn}

append :linked_files, "config/database.yml", "config/secrets.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", "public/uploads", ".bundle", "node_modules", "public/packs"

append :exclude_dir, "public/uploads log tmp vendor public/assets"


set :yarn_target_path, -> { release_path.join('.') } #
set :yarn_flags, '--production --silent --no-progress'    # default
set :yarn_roles, :all                                     # default
set :yarn_env_variables, {}

after 'deploy:publishing', 'deploy:restart'
after 'deploy', 'deploy:cleanup'
after 'deploy:updated', 'webpacker:precompile'