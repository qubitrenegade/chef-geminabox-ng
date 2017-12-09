# frozen_string_literal: true
#
# Cookbook:: geminabox-ng
# Library:: helper
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

module GeminaboxNG
  module Helpers
    def gib_username
      node['geminabox-ng']['user']['name']
    end

    def gib_config_file
      File.join(
        node['geminabox-ng']['user']['home_dir'],
        'config.ru',
      )
    end

    def unicorn_config_file
      File.join(
        node['geminabox-ng']['user']['home_dir'], 
        'geminabox.unicorn.app',
      )
    end

    def gib_data_dir
      node['geminabox-ng']['data_dir'] || File.join(
        node['geminabox-ng']['user']['home_dir'],
        'data',
      )
    end

    def gib_rack_env
      node['geminabox-ng']['unicorn']['rack_env'] || 'production'
    end

    def unicorn_path
      File.join(
        node['geminabox-ng']['user']['home_dir'],
        '.rbenv/shims/unicorn',
      )
    end
  end
end

Chef::Recipe.send(:include, GeminaboxNG::Helpers)
Chef::Mixin::Template.send(:include, GeminaboxNG::Helpers)
Chef::Mixin::Template::TemplateContext.send(:include, GeminaboxNG::Helpers)
Chef::Resource::Directory.send(:include, GeminaboxNG::Helpers)
