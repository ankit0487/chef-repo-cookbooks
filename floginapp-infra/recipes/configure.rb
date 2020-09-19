include_recipe 'apt::default'
package 'build-essential'
package 'git'

package 'python'
package 'python-pip'


package 'nginx'

package 'mysql'


# create app directories
directory node['floginapp-infra']['project_dir'] do
  recursive true
end

directory node['floginapp-infra']['config_dir'] do
  recursive true
end


# copy config files
template "/etc/nginx/sites-available/floginapp" do
   source 'floginapp-nginx.erb'
end

link '/etc/nginx/sites-enabled/floginapp' do
  to '/etc/nginx/sites-available/floginapp'
end

template "/etc/init/floginapp.conf" do
    source 'floginapp-gunicorn.conf.erb'
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