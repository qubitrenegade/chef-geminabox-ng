# frozen_string_literal: true
#
# Cookbook:: geminabox-ng
# Recipe:: server
#
# Install and configure the geminabox server
#
# The MIT License (MIT)
#
# Copyright:: 2017, QubitRenegade
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

# Create datadir
directory 'geminabox data directory' do
  owner node['geminabox-ng']['user']['name']
    path node['geminabox-ng']['data_dir'] || "#{node['geminabox-ng']['user']['home_dir']}/data"
  recursive true
  action :create
end

# install requisite gems
node['geminabox-ng']['gems'].each do |gem, include|
  next unless include
  rbenv_gem gem do
    # user node['geminabox-ng']['user']['name']
    rbenv_version node['geminabox-ng']['ruby_version']
    action :install
  end
end

# geminabox config
geminabox_config = File.join node['geminabox-ng']['user']['home_dir'], 'config.ru'
template geminabox_config do
  user node['geminabox-ng']['user']['name']
  group node['geminabox-ng']['user']['name']
  mode '0644'
  action :create
end

# Unicorn config
unicorn_config = File.join node['geminabox-ng']['user']['home_dir'], 'geminabox.unicorn.app'
template unicorn_config do
  source 'unicorn.app.erb'
  user node['geminabox-ng']['user']['name']
  group node['geminabox-ng']['user']['name']
  mode '0644'
  action :create
end

# Start geminabox
poise_service 'geminabox' do
  command "geminabox unicorn --config-file #{unicorn_config} #{geminabox_config}"
  user node['geminabox-ng']['user']['name']
  environment RACK_ENV: node['geminabox-ng']['unicorn']['rack_env'] || 'production'
  action :enable
end
