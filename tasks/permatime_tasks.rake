#thanks to Duff OMelia for this concept borrowed from his 'view' verb in his testing dsl

desc "Shows a preview of the maintenance page in a browser"
task :preview_maintenance do
  
  filename = File.dirname(__FILE__) + "/../../../../public/.maintenance_preview.html"
  maintenance = render("/app/views/layouts/maintenance.html.erb", 
  :deadline => ENV['UNTIL'],
  :reason => ENV['REASON'])
  put maintenance, filename, 
  :mode => 0644
  `open #{filename}`
end

def render(path_to_template_file,  options)
  path_to_template_file = RAILS_ROOT+path_to_template_file
  puts "railsroot:%s" % RAILS_ROOT
puts "pathtotemplatefile: %s" % path_to_template_file
deadline = options[:deadline]
  reason = options[:reason]
  require 'erb'
  template = File.read(path_to_template_file)
  result = ERB.new(template).result(binding)
end