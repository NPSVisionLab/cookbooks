#
# Cookbook Name:: nps-jenkins
# Recipe:: master
#
# Copyright (C) 2015 Naval Postgraduate School
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'jenkins::master'

#jenkins_keys = encrypted_data_bag_item('jenkins', 'keys')
require 'openssl'
require 'net/ssh'
#key = OpenSSL::PKey::RSA.new(jenkins_keys['private_key'])
#private_key = key.to_pem
#public_key = "#{key.ssh_type} #{[key.to_blob].pack('m0')}"

jenkins_user 'jenkins' do
 #public_keys [public_key]
end

#node.run_state[:jenkins_private_key] = private_key

jenkins_user 'trbatcha' do
end

jenkins_user 'matz' do
end

#jenkins_user 'bogus2' do
#  password 'bogus2'
#end

jenkins_password_credentials 'trbatcha' do
  id 'someidfortrbatcha'
  description 'trbatcha User in jenkins'
  password 'trbatcha'
end

jenkins_password_credentials 'matz' do
  id 'someidformatz'
  description 'matz User in jenkins'
  password 'matz'
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

#template "#{node['jenkins']['master']['home']}/config.xml" do
#    source "config.xml.erb"
#end

jenkins_command 'reload-configuration'
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

