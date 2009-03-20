# This run when the permatime_plugin installed
require 'ftools'
 
maintenance_layout = File.expand_path("#{File.dirname(__FILE__)}/../../../app/views/layouts/maintenance.html.erb")
default_maintenance_layout = "#{File.dirname(__FILE__)}/maintenance.html.erb"
 
if File::exists? maintenance_layout
  puts "You already have a maintenance layout at #{maintenance_layout}."
  puts "But, you might want to compare with ours:"
  puts "  #{default_maintenance_layout}"
else  
  puts "Installing default maintenance layout"
  puts "  From #{default_maintenance_layout}"
  puts "You may want to customize this"
  File.copy default_maintenance_layout, maintenance_layout
end
