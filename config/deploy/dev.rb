server "78.109.168.52", :app, :web, :db, :primary => true
set :domain,      "mazeclothing.co.uk"
set :deploy_to,   "/var/www/vhosts/mazeclothing.co.uk/htdocs"

set :branch, 'master'

set :deploy_via, :remote_cache
set :keep_releases,  3
set :symlink_extras,["/app",'/var','/media','/lib','/skin','/shell','/js']

after "deploy", "update_localxml"

task :update_localxml, :roles => :app do
	sudo "chmod 777 -R #{release_path}/app/etc"
	sudo "chmod 777 -R #{release_path}/media"
	sudo "chmod 777 -R #{release_path}/var"
end

