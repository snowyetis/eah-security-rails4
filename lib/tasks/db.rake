namespace :db do

  task :delete_devices => :environment do
    puts "Deleting driver devices"
    ActiveRecord::Base.connection.execute("DELETE FROM devices")
  end

  task :reset_passwords => :environment do
    puts "Reseting user passwords"
    ActiveRecord::Base.connection.execute("UPDATE users set encrypted_password = 'default_password'")
  end

  namespace :staging do

    desc 'Copies production data to staging database.'
    task :prod_refresh do
      Rake::Task["heroku:pgbackups:restore"].invoke(ENV["staging_app"], ENV["staging_database"])
      Rake::Task["heroku:rake"].invoke("db:staging:setup_data", ENV["staging_app"])
      Rake::Task["heroku:restart"].invoke(ENV["staging_app"])
    end

    task :setup_data => [:delete_devices, :reset_passwords]

  end

end
