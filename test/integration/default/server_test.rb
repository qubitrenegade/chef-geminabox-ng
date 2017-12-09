# # encoding: utf-8

# Inspec test for recipe geminabox-ng::server

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'config files' do
  %w(
    /opt/geminabox/data
    /opt/geminabox/geminabox.unicorn.app
    /opt/geminabox/config.ru
  ).each do |file|
    describe file file do
      it { should exist }
    end
  end
end

{
  'geminabox' => '0.13.11',
  'unicorn' => '5.3.1'
}.each do |gem_name, gem_version|
  control "geminabox gem: #{gem_name}" do
    describe gem gem_name, '/opt/geminabox/.rbenv/shims/gem' do
      it { should be_installed }
      its('version') { should eq gem_version }
    end
  end
end

control 'geminabox service' do
  describe upstart_service 'geminabox' do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
end
