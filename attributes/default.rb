# frozen_string_literal: true
# rubocop:disable Metrics/LineLength
default['geminabox-ng'] = {
  'user' => {
    'name'        => 'geminabox',             # use a default user of geminabox
    'home_dir'    => '/opt/geminabox',        # Set geminabox dir
    # 'data_dir'    => nil, # optionally configurable datadir, defaults to "#{home_dir}/data"
  },

  'config' => {                               # Set config options for geminabox server, see https://github.com/geminabox/geminabox
    'build_legacy'    => false,
    'rubygems_proxy'  => true,
    'allow_remote_failure' => true,
  },
  'ruby_version'  => '2.4.2',           # default to the latest as of this writing

  'gems' => {                           # list of gems to install, additional gems can be added here.
    'geminabox'   => true,
    'unicorn'     => true,
  },
  'unicorn' => {
    'worker_processes' => 4,
    'port' => '8080',
    'timeout' => 30,
    'preload_app' => true,
    'cow_friendly' => true,
  },

  'run_list' => {                       # By default, we'll run all redipes in the cookbook, set to false to disable a recipe
    'user'        => true,              # creates the geminabox user, disable if you create users via other processes
    'ruby'        => true,              # Installs ruby using rbenv, disable to use another ruby install method
    'server'      => true,              # Installs and configures geminabox, no sense disabling since this is the heart of the cookbook.
    'proxy'       => true,              # Sets up a reverse proxy to webrick service.  Currently only supports Nginx
  },
}
