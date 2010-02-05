# routes.rb
#
# ADD --> include CaseinAddRoutes
#
# ActionController::Routing::Routes.draw do |map|
#
#	ADD --> CaseinAddRoutes::mapper map

module CaseinAddRoutes
	
	def mapper map
		map.connect 'casein_users/update_password/:id', :controller => 'casein_users', :action => 'update_password', :conditions => { :method => :put }
		map.connect 'casein_users/reset_password/:id', :controller => 'casein_users', :action => 'reset_password', :conditions => { :method => :put }
		map.resources :casein_users
		
		map.connect 'admin/:action/:id', :controller => 'casein'
	  map.connect 'casein/:action/:id', :controller => 'casein'
	  map.connect 'casein_auth/:action/:id', :controller => 'casein_auth'
	end
		
end