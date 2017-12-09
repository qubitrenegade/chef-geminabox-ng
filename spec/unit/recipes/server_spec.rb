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

describe 'geminabox-ng::server' do
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

    it 'creates data_dir' do
      expect(chef_run).to create_directory('geminabox data directory')
        .with(
          owner: 'geminabox',
          path: '/opt/geminabox/data',
          recursive: true,
        )
    end

    %w(geminabox unicorn).each do |gem|
      it "installs requisite gem: #{gem}" do
        expect(chef_run).to install_rbenv_gem(gem)
          .with(
            user: 'geminabox',
            rbenv_version: '2.4.2',
          )
      end
    end

    it 'creates geminabox config.ru' do
      cfg_file = '/opt/geminabox/config.ru'
      expect(chef_run).to create_template(cfg_file)
      expect(chef_run).to render_file(cfg_file).with_content { |content|
        expect(content).to include 'Geminabox.build_legacy = false'
        expect(content).to include 'Geminabox.rubygems_proxy = true'
        expect(content).to include 'Geminabox.allow_remote_failure = true'
        expect(content).to include 'Geminabox.data = /opt/geminabox/data'
      }
    end

    it 'creates unicorn config' do
      cfg_file = '/opt/geminabox/geminabox.unicorn.app'
      expect(chef_run).to create_template(cfg_file)
        .with(
          user: 'geminabox',
         group: 'geminabox',
          mode: '0644',
        )

      expect(chef_run).to render_file(cfg_file).with_content { |content|
        expect(content).to include 'chefspec'
        expect(content).to include %q|working_directory '/opt/geminabox'|
        expect(content).to include %q|listen '8080'|
        expect(content).to include 'preload_app true'
        expect(content).to include 'copy_on_write_friendly = true'
      }
    end

    it 'enables geminabox service' do
      expect(chef_run).to enable_poise_service('geminabox')
    end
  end
end




















