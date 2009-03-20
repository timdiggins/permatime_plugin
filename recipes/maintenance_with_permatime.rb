#needs permatime maintenance recipe for cap
#thanks to Mike Clark for helpful pointers at http://clarkware.com/cgi/blosxom/2007/01/05 and in Advanced Rails Recipes

namespace :deploy do
  namespace :web do 
    desc "serve up a custom maintenance page with useful permatime of when went offline"
    task :disable, :roles => :web do
      require 'erb'
      
      on_rollback { run "rm #{shared_path}/system/maintenance.html" }
      
      path_to_template_file=File.dirname(__FILE__) + "/../../../app/views/layouts/maintenance.html.erb"
      
      deadline = ENV['UNTIL']
      reason = ENV['REASON']
      template = File.read(path_to_template_file)
      page = ERB.new(template).result(binding)
      
      put page, "#{shared_path}/system/maintenance.html", :mode => 0644
    end
  end 
end
