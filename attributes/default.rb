
default['pgsql']['version'] = '9.3'

default['pgsql']['hba'] = [
  {:type => 'local', :database => 'all', :user => 'all', :address => '', :method => 'peer'},
  {:type => 'host', :database => 'all', :user => 'all', :address => '127.0.0.1/32', :method => 'ident'},
  {:type => 'host', :database => 'all', :user => 'all', :address => '::1/128', :method => 'ident'}
]

default['pgsql']['conf']['listen_addresses'] = 'localhost'
default['pgsql']['conf']['port'] = '5432'
default['pgsql']['conf']['log_filename'] = 'postgresql-%a.log'
default['pgsql']['conf']['log_line_prefix'] = '< %m >'
default['pgsql']['conf']['log_timezone'] = 'UTC'
default['pgsql']['conf']['log_statement'] = 'none'
default['pgsql']['conf']['log_connections'] = 'off'
default['pgsql']['conf']['log_disconnections'] = 'off'


default['pgsql']['repo_rul'] = {
    '9.4' => {
        'centos' => {
            '7' => 'http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-centos94-9.4-1.noarch.rpm',
            '6' => 'http://yum.postgresql.org/9.4/redhat/rhel-6-x86_64/pgdg-centos94-9.4-1.noarch.rpm'
        }
    },
    '9.3' => {
        'centos' => {
            '7' => 'http://yum.postgresql.org/9.3/redhat/rhel-7-x86_64/pgdg-centos93-9.3-1.noarch.rpm',
            '6' => 'http://yum.postgresql.org/9.3/redhat/rhel-6-x86_64/pgdg-centos93-9.3-1.noarch.rpm'
        }
    }
}