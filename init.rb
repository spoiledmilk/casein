$CASEIN_MAJOR_VERSION = 2
$CASEIN_MINOR_VERSION = 0
$CASEIN_BUILD_INFO = 6

puts "-- Booting Casein v.#{$CASEIN_MAJOR_VERSION}.#{$CASEIN_MINOR_VERSION}.#{$CASEIN_BUILD_INFO}"

config.gem "calendar_date_select", :version => '1.15'
config.gem 'mislav-will_paginate', :version => '~> 2.3.11', :lib => 'will_paginate', :source => 'http://gems.github.com'

%w{ models controllers helpers }.each do |dir|
  path = File.join(directory, 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

ActionController::Base.append_view_path File.join(directory, 'app/views')

begin
	ActionView::Base.send :include, CaseinHelper
	ActionView::Base.send :include, CaseinConfigHelper
rescue
end