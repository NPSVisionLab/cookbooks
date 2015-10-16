#
# Cookbook Name:: nps-jenkins
# Recipe:: slave
#
# Copyright (C) 2015 Naval Postgraduate School
#
# All rights reserved - Do Not Redistribute
#

# this should run apt-get update:
include_recipe 'apt'

package 'openjdk-7-jre'
package 'git'
package 'cmake'
