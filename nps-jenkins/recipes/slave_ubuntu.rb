#
# Cookbook Name:: nps-jenkins
# Recipe:: slave_ubuntu
#
# Copyright (C) 2015 Naval Postgraduate School
#
# All rights reserved - Do Not Redistribute
#

# this should run apt-get update:
include_recipe 'apt'

#needed to fetch the opencv_nonfree
execute "add-apt-repository --yes ppa:xqms/opencv-nonfree" do
  user "root"
end

execute "apt-get update" do
  user "root"
end

package 'libopencv-nonfree-dev'

package 'openjdk-7-jre'
package 'git'
package 'cmake'
package 'gcc'
package 'g++'
package 'make'
package 'doxygen'
package 'zeroc-ice35'
package 'jekyll'
package 'libarchive-dev'
package 'python-zeroc-ice'
package 'libzeroc-ice35'
package 'libzeroc-ice35-dev'
package 'libslice35'
package 'libopencv-dev'
package 'python-opencv'
package 'libopencv-calib3d-dev'
package 'libopencv-core-dev'
package 'libopencv-features2d-dev'
package 'libopencv-gpu-dev'
package 'libopencv-highgui-dev'
package 'libopencv-ml-dev'
package 'libopencv-objdetect-dev'
