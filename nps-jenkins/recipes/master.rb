#
# Cookbook Name:: nps-jenkins
# Recipe:: master
#
# Copyright (C) 2015 Naval Postgraduate School
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'jenkins::master'

include_recipe 'nps-jenkins::plugins'

jenkins_user 'bogus' do
  password 'bogus'
end

jenkins_user 'bogus2' do
  password 'bogus2'
end

jenkins_password_credentials 'vagrant' do
  id 'someidforvagrant'
  description 'Vagrant User in jenkins'
  password 'vagrant'
end

jenkins_password_credentials 'jenkins' do
  id 'someidforjenkins'
  description 'Jenkins User'
  password 'jenkins'
end

# Create a slave launched via SSH
jenkins_ssh_slave 'Ubuntu builder' do
  description 'Build on Ubuntu'
  remote_fs   '/home/vagrant'
  labels      ['build', 'ubuntu']

  # SSH specific attributes
  host        '192.168.100.2'
#  user        'jenkins'
#  credentials 'mnbt78654wdfgh'
  user        'vagrant'
  credentials 'vagrant'
end

# copy files/config.xml to the guest
osx_xml = File.join(Chef::Config[:file_cache_path], 'config.xml')
cookbook_file osx_xml do
  source 'build-osx/config.xml'
end
# Create a jenkins job (default action is `:create`)
jenkins_job 'build_OSX' do
  config osx_xml
end
ubuntu_xml = File.join(Chef::Config[:file_cache_path], 'config.xml')
cookbook_file ubuntu_xml do
  source 'build-ubuntu/config.xml'
end
# Create a jenkins job (default action is `:create`)
jenkins_job 'build_Ubuntu' do
  config ubuntu_xml
end

directory '/home/vagrant/workspace' do
  owner 'jenkins'
  action :create
  mode '0777'
end
directory '/home/vagrant/workspace/build_Ubuntu' do
  owner 'jenkins'
  action :create
  mode '0777'
end
