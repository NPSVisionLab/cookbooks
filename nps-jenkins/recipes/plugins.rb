


# Cookbook Name:: jenkins-chef-dsl 
# Recipe:: plugins 
# 
# Installs Jenkins plugins 


# TODO: When this issue is merged see if we can resolve dependacies instead 
#  https://github.com/opscode-cookbooks/jenkins/pull/175 


# Flag set to true if plugin is installed or updated and jenkins will be restarted. 
#  Pattern from https://tickets.opscode.com/browse/CHEF-2452 
restart_required = false 
 

### Plugins Start ### 
# git-essentails, add other scm's here 
# Install specific version, if provided. Syntax: plugin=1.0.0 
#  Credit: https://github.com/JacksonRiver/chef-jr-jenkins/blob/master/recipes/plugins.rb#L13 
package 'git' 
package 'cmake'
%w(credentials ssh-credentials git-client scm-api github github-api github-oauth mailer).each do |plugin| 
  plugin, version = plugin.split('=') 
  jenkins_plugin plugin do 
    version version if version 
    notifies :create, "ruby_block[jenkins_restart_flag]", :immediately 
  end 
end 
 

# More others 
%w(cmakebuilder copyartifact envinject windows-slaves).each do |plugin| 
  plugin, version = plugin.split('=') 
  jenkins_plugin plugin do 
    version version if version 
    notifies :create, "ruby_block[jenkins_restart_flag]", :immediately 
  end 
end 
### Plugins End ### 
 

 

 # Is notified only when a 'jenkins_plugin' is installed or updated. 
ruby_block "jenkins_restart_flag" do 
  block do 
    restart_required = true 
  end 
  action :nothing 
end 
 

jenkins_command 'restart' do 
  only_if { restart_required } 
end 

