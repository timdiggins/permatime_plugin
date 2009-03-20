# This run when the permatime_plugin installed
require 'ftools'
 
maintenance_layout = File.expand_path(RAILS_ROOT)+"/app/views/layouts/maintenance.html.erb"
default_maintenance_layout = File.expand_path(File.dirname(__FILE__))+"/maintenance.html.erb"

def hr
  puts "-" *80

if File::exists? maintenance_layout
  hr
  puts "You already have a maintenance layout at #{maintenance_layout}."
  hr
  puts "But, you might want to compare with ours:"
  puts "  #{default_maintenance_layout}"
  hr
else  
  hr
  puts "Installing default maintenance layout"
  puts "  to #{maintenance_layout}"
  hr
  puts "You definitely want to customize this" 
  puts "  (put your correct APP_NAME and email address)"
  File.copy default_maintenance_layout, maintenance_layout
  hr
end
