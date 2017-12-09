#
# Cookbook:: geminabox-ng
# Spec:: default
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

require 'spec_helper'

describe 'geminabox-ng::proxy' do
  context 'When all attributes are default, on an Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'installs nginx' do
      expect(chef_run).to install_package 'nginx'
    end

    it 'starts and enables nginx' do
      expect(chef_run).to start_service 'nginx'
      expect(chef_run).to enable_service 'nginx'
    end

    it 'removes the default config file' do
      expect(chef_run).to delete_file '/etc/nginx/conf.d/default.conf'
    end

    it 'creates geminabox.conf file' do
      cfg_file = '/etc/nginx/conf.d/geminabox.conf'
      expect(chef_run).to create_template cfg_file
      expect(chef_run).to render_file(cfg_file).with_content { |content|
        expect(content).to match %r{proxy_pass\s+http:\/\/127.0.0.1:8080;}
        expect(content).to include 'listen 8000 default deferred;'
      }
    end
  end
end
