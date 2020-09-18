# general settings
default['floginapp-infra']['app_name'] = 'floginapp'
default['floginapp-infra']['project_root'] = '/srv/www/'
default['floginapp-infra']['project_dir'] = '/srv/www/floginapp/'
default['floginapp-infra']['app_dir'] = '/srv/www/floginapp/current/floginapp/' # AWS uses current
default['floginapp-infra']['config_dir'] = '/etc/floginapp/' # Must update app if this changes

# nginx settings
default['floginapp-infra']['server_port'] = '80'
default['floginapp-infra']['server_name'] = '127.0.0.1'
default['floginapp-infra']['nginx_logfile'] = '/var/log/nginx/access.log' # default
default['floginapp-infra']['nginx_errorfile'] = '/var/log/nginx/error.log' # default
default['floginapp-infra']['nginx_user'] = 'www-data' # default
default['floginapp-infra']['nginx_group'] = 'www-data'

# gunicorn settings
default['floginapp-infra']['gunicorn_socket'] = '/tmp/floginapp.sock'

