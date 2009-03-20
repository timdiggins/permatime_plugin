#thanks to Duff OMelia for this concept borrowed from his 'view' verb in his testing dsl

require File.dirname(__FILE__) + "/../lib/permatime_helper.rb"

desc "Shows a preview of the maintenance page in a browser"
task :preview_maintenance do  
  filename = File.dirname(__FILE__) + "/../../../../public/.maintenance_preview.html"
  maintenance = render("/app/views/layouts/maintenance.html.erb", 
  :deadline => ENV['UNTIL'],
  :reason => ENV['REASON'])
  File.open(filename, 'w+') do |f|
    f << maintenance
  end
  `open #{filename}`
end

def render(path_to_template_file,  options)
  include PermatimeHelper
  path_to_template_file = RAILS_ROOT+path_to_template_file
  deadline = options[:deadline]
  reason = options[:reason]
  require 'erb'
  template = File.read(path_to_template_file)
  result = ERB.new(template).result(binding)
end