# # encoding: utf-8

# Inspec test for recipe geminabox-ng::default

# This is an example test, replace it with your own test.
describe port(80), :skip do
  it { should_not be_listening }
end
