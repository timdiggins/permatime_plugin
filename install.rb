# This run when the permatime_plugin installed
require 'ftools'
 
maintenance_layout = File.expand_path(RAILS_ROOT)+"/app/views/layouts/maintenance.html.erb"
default_maintenance_layout = File.expand_path(File.dirname(__FILE__))+"/maintenance.html.erb"

def hr
  puts "-" *80
end

if File::exists? maintenance_layout
  hr
  puts "You already have a maintenance layout at #{maintenance_layout}."
  hr
  puts "But, you might want to compare with ours:"
  puts "  #{default_maintenance_layout}"
  puts " and use 'rake preview_maintenance' to see what it will look like"

  hr
else  
  hr
  puts "Installing default maintenance layout"
  puts "  to #{maintenance_layout}"
  hr
  puts "You definitely want to customize this" 
  puts "  (put your correct app_name and twitter_id for example)"
  File.copy default_maintenance_layout, maintenance_layout
  puts " 'rake preview_maintenance' to see what it will look like"
  hr
end

