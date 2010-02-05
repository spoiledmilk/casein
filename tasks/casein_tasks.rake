namespace :casein do
  desc "Migrate database, remove all users, create default admin user"
  task :init => :environment do
    Rake::Task['db:migrate'].invoke 
    Rake::Task['casein:users:remove_all'].invoke 
    Rake::Task['casein:users:create_admin'].invoke
    
    puts "[Casein] Initialised project"    
  end
  
end