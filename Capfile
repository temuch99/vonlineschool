require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rvm'
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git


require 'capistrano/copy'
require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/puma'
require 'capistrano/yarn'
require 'capistrano/webpacker/precompile'
require 'capistrano/rails/console'

# install_plugin Capistrano::Puma

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }