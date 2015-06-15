pgsql_version_p = node['pgsql']['version']
pgsql_version = node['pgsql']['version'].split('.').join

#postgresqlレポジトリ 取得＆インストール
remote_file '/tmp/pgdg.rpm' do
  source node['pgsql']['repo_rul'][node[ :pgsql ][ :version ]][node[ :platform ]][node[ :platform_version ].to_i.to_s]
end
rpm_package 'postgresql repo install' do
  action :install
  source '/tmp/pgdg.rpm'
  # not_if {File.exists?('/var/lib/pgsql/9.3/data/PG_VERSION')}
end

#postgresqlインストール
list = %W(postgresql#{pgsql_version}-server postgresql#{pgsql_version}-contrib)
# list = %w(postgresql93-server postgresql93-contrib)
package list do
  action :install
  options '--enablerepo=pgdg'+pgsql_version
end

#postgresql 初期化コマンド実行
if platform?('centos') and node[ :platform_version ].to_i == 7
  execute 'postgresql init DB' do
    command "/usr/pgsql-#{pgsql_version_p}/bin/postgresql#{pgsql_version}-setup initdb"
    not_if {File.exists?("/var/lib/pgsql/#{pgsql_version_p}/data/PG_VERSION")}
  end
else
  execute 'postgresql init DB' do
    command "service postgresql-#{pgsql_version_p} initdb"
    not_if {File.exists?("/var/lib/pgsql/#{pgsql_version_p}/data/PG_VERSION")}
  end
end

#postgresql 設定ファイル上書き
template "/var/lib/pgsql/#{pgsql_version_p}/data/pg_hba.conf" do
  source "#{pgsql_version_p}/pg_hba.conf.erb"
  mode 0700
  notifies :restart, "service[postgresql-#{pgsql_version_p}]"
end
template "/var/lib/pgsql/#{pgsql_version_p}/data/postgresql.conf" do
  source "#{pgsql_version_p}/postgresql.conf.erb"
  mode 0700
  notifies :restart, "service[postgresql-#{pgsql_version_p}]"
end

#サービス起動＆自動起動
service "postgresql-#{pgsql_version_p}" do
  action [:enable, :start]
end