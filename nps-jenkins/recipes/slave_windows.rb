#
# Cookbook Name:: nps-jenkins
# Recipe:: slave_windows
#
# Copyright (C) 2015 Naval Postgraduate School
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'seven_zip'
include_recipe 'visualstudio'
node.default['visualstudio']['installs']['source'] = ['windows/X16-81637VS2010ProMSDN.iso']
node.default['visualstudio']['installs']['version'] = ['2010']
node.default['visualstudio']['installs']['edition'] = ['professional']
