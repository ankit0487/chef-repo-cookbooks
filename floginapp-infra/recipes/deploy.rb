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

# start gunicorn service from supervisor
execute 'start app from supervisor' do
  command "sudo supervisorctl start #{node['floginapp-infra']['app_name']}"
end
  
service 'nginx' do
action :restart
end