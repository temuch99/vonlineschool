require 'capistrano/setup'
require 'capistrano/deploy'
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git


require 'sshkit/sudo'
require 'capistrano/copy'
require 'capistrano/rails'
require 'capistrano/bundler'
require 'capistrano/rvm'
require 'capistrano/puma'
require 'capistrano/yarn'
require 'capistrano/webpacker/precompile'
require 'capistrano/rails/console'

install_plugin Capistrano::Puma
# install_plugin Capistrano::Puma::Nginx
# install_plugin Capistrano::Puma::Systemd

Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }