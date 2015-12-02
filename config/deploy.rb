set :repo_url, 'git@github.com:digitalshop24/velo.git'
set :application, 'velo'
application = 'velo'
set :rvm_type, :user
set :rvm_ruby_version, '2.2.1'
set :deploy_to, '/var/www/apps/velo'

lock '3.4.0'

namespace :git do
  desc 'Deploy'
  task :deploy do
    ask(:message, "Commit message?")
    run_locally do
      execute "git add -A"
      execute "git commit -m '#{fetch(:message)}'"
      execute "git push"
    end
  end
end

namespace :server do
  rails_env = 'production'
  desc 'Start server'
  task :start do
    on roles(:all) do
      within current_path do
        execute "cd #{current_path}"
        execute :bundle, "exec unicorn_rails -c #{current_path}/config/unicorn.rb -E #{rails_env}"
      end      
    end
  end

  desc "Initiate a rolling restart by telling Unicorn to start the new application code and kill the old process when done."
  task :restart do
    on roles(:all) do
      execute "kill -USR2 $(cat /var/www/apps/velo/run/unicorn.pid)"
    end
  end

  desc "Stop the application by killing the Unicorn process"
  task :stop do
    on roles(:all) do      
      execute "kill $(cat #{deploy_to}/run/unicorn.pid)"
    end
  end
end

namespace :deploy do

  desc 'Setup'
  task :setup do
    on roles(:all) do
      execute "mkdir  #{shared_path}/config/"
      execute "mkdir  /var/www/apps/#{application}/run/"
      execute "mkdir  /var/www/apps/#{application}/log/"
      execute "mkdir  /var/www/apps/#{application}/socket/"
      execute "mkdir #{shared_path}/system"

      upload!('shared/database.yml', "#{shared_path}/config/database.yml")
      upload!('shared/secrets.yml', "#{shared_path}/config/secrets.yml")

      upload!('shared/Procfile', "#{shared_path}/Procfile")

      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, "db:create"
        end
      end
    end
  end

  desc 'Create symlink'
  task :symlink do
    on roles(:all) do
      execute "ln -s #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      execute "ln -s #{shared_path}/Procfile #{release_path}/Procfile"
      execute "ln -s #{shared_path}/system #{release_path}/public/system"
      execute "ln -s #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
    end
  end

  after :finishing, 'deploy:cleanup'
  after :finishing, 'deploy:restart'

  after :updating, 'deploy:symlink'

  before :setup, 'deploy:starting'
  before :setup, 'deploy:updating'
  before :setup, 'bundler:install'
end
