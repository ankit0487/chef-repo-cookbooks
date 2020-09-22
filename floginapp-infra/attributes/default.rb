# general settings
default['floginapp-infra']['app_name'] = 'sampleflaskapp'
default['floginapp-infra']['project_root'] = '/srv/www/'
default['floginapp-infra']['project_dir'] = '/srv/www/sampleflaskapp/'
default['floginapp-infra']['app_dir'] = '/srv/www/sampleflaskapp/current/' # AWS uses current
default['floginapp-infra']['config_dir'] = '/etc/sampleflaskapp/' # Must update app if this changes

# nginx settings
default['floginapp-infra']['server_port'] = '80'
default['floginapp-infra']['server_name'] = 'localhost'
default['floginapp-infra']['nginx_logfile'] = '/var/log/nginx/access.log' # default
default['floginapp-infra']['nginx_errorfile'] = '/var/log/nginx/error.log' # default
default['floginapp-infra']['nginx_user'] = 'www-data' # default
default['floginapp-infra']['nginx_group'] = 'www-data'

# gunicorn settings
default['floginapp-infra']['gunicorn_socket'] = '/tmp/sampleflaskapp.sock'

