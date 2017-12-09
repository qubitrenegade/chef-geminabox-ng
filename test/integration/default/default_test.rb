# # encoding: utf-8

# Inspec test for recipe geminabox-ng::default

describe port(80) do
  it { should_not be_listening }
end
