package 'apt'
# apt_update 
execute 'apt_update' do
  command 'sudo apt-get update'
end
package 'build-essential'
package 'git'
package 'curl'

#install python 3.6 and pip
execute 'install_python3.6' do
  command 'sudo add-apt-repository ppa:jonathonf/python-3.6'
  command 'sudo apt-get update'
  command 'sudo apt-get -y install python3.6'
  command 'sudo apt-get -y install python3-pip'
end

package 'nginx'

#install gnuicorn
execute 'gunicorn' do
  command 'pip3 install gunicorn'
end

# create app directories
directory node['floginapp-infra']['project_dir'] do
  recursive true
end

directory node['floginapp-infra']['config_dir'] do
  recursive true
end


# copy nginx config files
template "/etc/nginx/sites-available/floginapp" do
  source 'floginapp-nginx.conf.erb'
end

link '/etc/nginx/sites-enabled/floginapp' do
  to '/etc/nginx/sites-available/floginapp'
end

# set up logging
# nginx
file node['floginapp-infra']['nginx_logfile'] do
  mode '0644'
  owner node['floginapp-infra']['nginx_user']
  group node['floginapp-infra']['nginx_group']
end

file node['floginapp-infra']['nginx_errorfile'] do
  mode '0644'
  owner node['floginapp-infra']['nginx_user']
  group node['floginapp-infra']['nginx_group']
end

# start nginx
# note: start as sudo, will spawn child processes w/ www-data owner
service 'nginx' do
  supports :status => true
  action [:enable, :start]
end


#install supervisor
package 'supervisor'

# copy supervisor config files
template "/etc/supervisor/conf.d/#{node['floginapp-infra']['app_name']}.conf" do
  source 'floginapp-gunicorn.conf.erb'
end

execute 'supervisor_reread' do
  command 'sudo supervisorctl reread'
  command 'sudo supervisorctl update'
end