Chef::Log.info("Running deploy/before_restart.rb...")

rails_env = new_resource.environment["RAILS_ENV"]
Chef::Log.info("Precompiling assets for #{rails_env}...")

node[:deploy].each do |application, deploy|
  deploy[:environment_variables].each do |key, value|
    Chef::Log.info("Setting ENV[#{key}] to #{value}")
    ENV[key] = value
  end
end
