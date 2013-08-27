require 'capistrano/ext/multistage'

set :application, "Maze"
set :repository,  "git@github.com:lookstechnical/maze.git"
set :scm,         :git
set :scm_passphrase, "ciaran"

set :app_symlinks, ["/media", "/var",  ]
set :app_shared_dirs, ["/media", "/var", ]
set :app_shared_files,["/app/etc/local.xml"]

set :stages, ["dev", "production"]
set :default_stage, "dev"

namespace :deploy do
  namespace :assets do
    task :precompile, :roles => :web, :except => { :no_release => true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes"
      end
    end
  end
end
set  :keep_releases,  3
