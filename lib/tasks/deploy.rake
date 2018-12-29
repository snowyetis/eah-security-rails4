namespace :deploy do

  desc 'Deploys a branch to staging. Use DEPLOY_BRANCH to specify which branch to deploy.'
  task :staging do
    Rake::Task["deploy:environment"].invoke("staging")
  end

  desc 'Deploys a branch to production. Use DEPLOY_BRANCH to specify which branch to deploy.'
  task :production do
    Rake::Task["deploy:environment"].invoke("production")
  end

  task :environment, :env do |t, args|
    deploy_branch(ENV["DEPLOY_BRANCH"], args.env)
    Rake::Task["heroku:migrate"].invoke(ENV["#{args.env}_app"])
    Rake::Task["heroku:restart"].invoke(ENV["#{args.env}_app"])
  end

  def deploy_branch(branch, environment)
    if branch
      sh "git push #{environment} #{branch}:master"
    else
      puts "Please, specify a branch to deploy."
      puts "Usage => deploy:staging DEPLOY_BRANCH=release_0.15"
      exit 1
    end
  end

end
