# # encoding: utf-8

# Inspec test for recipe geminabox-ng::proxy

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
control 'nginx' do
  title 'Configure nginx'
  desc 'Nginx should be configured'
  impact 1.0

  describe package('nginx') do 
    it { should be_installed }
  end

  describe service('nginx') do
    it { should be_running }
    it { should be_enabled }
  end

  describe port(8000) do
    it { should be_listening }
  end
end
