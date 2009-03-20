#thanks to Duff OMelia for this concept borrowed from his 'view' verb in his testing dsl

task :preview_maintenance do
  filename = File.dirname(__FILE__) + "/../../../../public/.maintenance_preview.html"
  maintenance = render("./app/views/layouts/maintenance.html.erb", 
      :deadline => ENV['UNTIL'],
      :reason => ENV['REASON'])
  put maintenance, filename, 
      :mode => 0644
  `open #{filename}`
end
