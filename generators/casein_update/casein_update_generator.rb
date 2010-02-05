class CaseinUpdateGenerator < Rails::Generator::Base
  def manifest
	
		puts "*** Updating Casein assets. It should be ok to overwrite these safely. ***"
	
    record do |m|
      
      #stylesheets
			m.file "public/casein/stylesheets/screen.css", "public/casein/stylesheets/screen.css"
			m.file "public/casein/stylesheets/elements.css", "public/casein/stylesheets/elements.css"
			m.file "public/casein/stylesheets/login.css", "public/casein/stylesheets/login.css"
			m.file "public/casein/stylesheets/calendar.css", "public/stylesheets/calendar_date_select/casein.css"
			
			#javascripts
			m.file "public/casein/javascripts/casein.js", "public/casein/javascripts/casein.js"
			m.file "public/casein/javascripts/login.js", "public/casein/javascripts/login.js"
      
      #images
      m.file "public/casein/images/header.png", "public/casein/images/header.png"
      m.file "public/casein/images/nav.png", "public/casein/images/nav.png"
      m.file "public/casein/images/rightNav.png", "public/casein/images/rightNav.png"
      m.file "public/casein/images/rightNavButton.png", "public/casein/images/rightNavButton.png"
      m.file "public/casein/images/casein.png", "public/casein/images/casein.png"
      m.file "public/casein/images/visitSiteNav.png", "public/casein/images/visitSiteNav.png"
			m.file "public/casein/images/login/top.png", "public/casein/images/login/top.png"
		  m.file "public/casein/images/login/bottom.png", "public/casein/images/login/bottom.png"

			#icons
			all_icons = Dir.new(source_path('public/casein/images/icons/')).entries

			for icon in all_icons
				if File.extname(icon) == ".png"
					m.file "public/casein/images/icons/#{icon}", "public/casein/images/icons/#{icon}"
				end
			end
			
			puts "** Additional icons can be downloaded from FamFamFam and should be placed in the public/casein/images/icons directory **"
			puts "** http://www.famfamfam.com/lab/icons/silk/ **"
			

    end
  end
end