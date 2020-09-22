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
    # cwd "#{@application[:deploy_to]}"
    command 'pip3 install -r requirements.txt'
end

# start gunicorn service
# service 'sampleflaskapp' do
#     provider Chef::Provider::Service::Upstart
#     supports :status => true
#     action [:restart]
# end
execute 'start_sampleflaskapp_gunicorn' do
  cwd node['floginapp-infra']['app_dir']
  # command "cd #{node['floginapp-infra']['app_dir']}"
  command "gunicorn --workers 3 --bind unix:#{node['floginapp-infra']['gunicorn_socket']} -m 007 wsgi:app"
end
  
service 'nginx' do
action :restart
end