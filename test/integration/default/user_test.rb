# # encoding: utf-8

# Inspec test for recipe geminabox-ng::user

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'Geminabox User' do
  describe user('geminabox') do
    it { should exist }
    its('home') { should eq '/opt/geminabox' }
    its('shell') { should eq '/bin/bash' }
  end
end
