#needs permatime maintenance recipe for cap
#thanks to Mike Clark for helpful pointers at http://clarkware.com/cgi/blosxom/2007/01/05 and in Advanced Rails Recipes

task :disable_web, :roles => :web do
  on_rollback { delete "#{shared_path}/system/maintenance.html" }
  
  maintenance = render("app/views/layouts/maintenance.html.erb", 
      :deadline => ENV['UNTIL'],
                       :reason => ENV['REASON'])
                       
  put maintenance, "#{shared_path}/system/maintenance.html", 
      :mode => 0644
end

def render(path_to_template_file,  options)
  path_to_template_file=File.dirname(__FILE__) + "/../../../"+path_to_template_file
  `ls -al #{path_to_template_file}`
  deadline = options[:deadline]
  reason = options[:reason]
  require 'erb'
  template = File.read(path_to_template_file)
  result = ERB.new(template).result(binding)
end
