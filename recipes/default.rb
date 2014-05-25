#
# Cookbook Name:: zsh
# Recipe:: default
#
# Author:: Shuichi Kura <shuichi.kura@gmail.com>
#

begin
  # Becomes include_recipe 'zsh::_packge'
  # The recipe starts with an underscore because it's not meant to be used
  # in a run_list (and should only be included by this recipe).
  include_recipe "zsh::_#{node['zsh']['install_method']}"
rescue Chef::Exceptions::RecipeNotFound
  Chef::Application.fatal! "'#{node['zsh']['install_method']}' is not a valid installation method for the zsh cookbook!"
end
