#
# Cookbook Name:: nps-jenkins
# Recipe:: master
#
# Copyright (C) 2015 Naval Postgraduate School
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'jenkins::master'

jenkins_plugin 'cmakebuilder' do
end

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
xml = File.join(Chef::Config[:file_cache_path], 'config.xml')
cookbook_file xml do
  source 'config.xml'
end
# Create a jenkins job (default action is `:create`)
jenkins_job 'build_OSX' do
  config xml
end
