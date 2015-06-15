require 'serverspec'

set :backend, :exec

describe package('postgresql94-server') do
  it { should be_installed }
end

describe port('5432') do
  it { should be_listening }
end

describe file('/var/lib/pgsql/9.4/data/PG_VERSION') do
  its(:content) { should match /9.4/ }
end

describe file('/var/lib/pgsql/9.4/data/pg_hba.conf') do
  its(:content) { should match /0.0.0.0\/0/ }
end

describe file('/var/lib/pgsql/9.4/data/postgresql.conf') do
  its(:content) { should match /log_filename = 'postgresql01-%a.log'/ }
end