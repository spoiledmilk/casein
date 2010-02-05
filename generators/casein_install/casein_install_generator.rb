class CaseinInstallGenerator < Rails::Generator::Base
  def manifest
	
		puts "*** WARNING - Generating configuration files. Make sure you have backed up any files before overwriting them. ***"
		
    record do |m|
      
      #create directories
      m.directory "app/views/casein_layouts/"
      m.directory "public/casein/"
      m.directory "public/casein/images/"
      m.directory "public/casein/images/icons/"
      m.directory "public/casein/images/login/"
      m.directory "public/casein/javascripts/"
      m.directory "public/casein/stylesheets/"
			m.directory "public/stylesheets/calendar_date_select/"

      #helpers
      m.file "app/helpers/casein_config_helper.rb", "app/helpers/casein_config_helper.rb"
      
      #view partials
      m.file "app/views/casein_layouts/_navigation.html.erb", "app/views/casein_layouts/_navigation.html.erb"
      m.file "app/views/casein_layouts/_right_navigation.html.erb", "app/views/casein_layouts/_right_navigation.html.erb"
     
			#blank stylesheets and javascript files
			m.file "public/casein/stylesheets/custom.css", "public/casein/stylesheets/custom.css"
			m.file "public/casein/javascripts/custom.js", "public/casein/javascripts/custom.js"

      #migrations
      m.migration_template "db/migrate/casein_create_users.rb", "db/migrate", :migration_file_name => 'casein_create_users'
      
    end
  end
end