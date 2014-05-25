#
# Cookbook Name:: zsh
# Attribute:: default
# Author:: Shuichi Kura <shuichi.kura@gmail.com>
#

default['zsh']['install_method'] = case node['platform_family']
                                    when 'rhel'
                                      'source'
                                    else
                                      'package'
                                    end

default['zsh']['version'] = '5.0.5'

default['zsh']['configure_options'] = []
