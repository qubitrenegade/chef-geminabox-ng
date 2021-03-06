name              'geminabox-ng'
maintainer        'QubitRenegade'
maintainer_email  'qubitrenegade@gmail.com'
license           'MIT'
description       'Installs/Configures geminabox-ng'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '0.1.1'
chef_version      '>= 12.1' if respond_to?(:chef_version)

%w(centos rhel ubuntu arch).each do |platform|
  supports platform
end

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://github.com/qubitrenegade/geminabox-ng/issues'

# The `source_url` points to the development reposiory for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://github.com/qubitrenegade/chef-geminabox-ng/tree/v0.1.1'

depends 'ruby_rbenv'
depends 'poise-service'
