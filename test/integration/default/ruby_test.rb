# # encoding: utf-8

# Inspec test for recipe geminabox-ng::ruby

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

control 'rbenv' do
  describe file('/opt/geminabox/.rbenv/bin/rbenv') do
    it { should exist }
  end
end

control 'ruby' do
  %w(
    /opt/geminabox/.rbenv/shims/ruby
    /opt/geminabox/.rbenv/versions/2.4.2/bin/ruby
  ).each do |ruby|
    describe file(ruby) do
      it { should exist }
    end
  end
end
