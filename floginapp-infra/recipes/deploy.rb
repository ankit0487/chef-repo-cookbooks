include_recipe 'deploy'

node[:deploy].each do |application, deploy|
  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end
end

execute 'update packages' do
    cwd node['floginapp-infra']['app_dir']
    command 'pip install -r requirements.txt'
end

# start gunicorn service
service 'floginapp' do
    provider Chef::Provider::Service::Upstart
    supports :status => true
    action [:restart]
end
  
service 'nginx' do
action :restart
end