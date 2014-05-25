#
# Cookbook Name:: zsh
# Recipe:: source
# Author:: Shuichi Kura <shuichi.kura@gmail.com>
#

packages = case node['platform_family']
           when 'rhel'
             %w(ncurses-devel)
           else
             %w(libncurses5-dev yodl)
           end

packages.each do |name|
  package name
end


tar_name = "zsh-#{node['zsh']['version']}"
remote_file "#{Chef::Config['file_cache_path']}/#{tar_name}.tar.gz" do
  source   "https://github.com/zsh-users/zsh/archive/#{tar_name}.tar.gz"
  notifies :run, 'bash[install_zsh]', :immediately
end

bash 'install_zsh' do
  user 'root'
  cwd  Chef::Config['file_cache_path']
  code <<-EOH
    tar -zxf #{tar_name}.tar.gz
    cd zsh-#{tar_name}
    ./Util/preconfig
    ./configure #{node['zsh']['configure_options'].join(" ")} --with-tcsetpgrp
    make
    make install
    sh -c 'echo /usr/local/bin/zsh >> /etc/shells'
  EOH
  action :nothing
end

tar_name = "zsh-completions"
remote_file "#{Chef::Config['file_cache_path']}/#{tar_name}.tar.gz" do
  source   "https://github.com/zsh-users/zsh-completions/archive/master.tar.gz"
  notifies :run, 'bash[install_zsh_completions]', :immediately
end

bash 'install_zsh_completions' do
  user 'root'
  cwd  Chef::Config['file_cache_path']
  code <<-EOH
    tar -zxf #{tar_name}.tar.gz
    cd #{tar_name}-master
    cp -rp src /usr/local/share/zsh-completions
  EOH
  action :nothing
end
