#
# Wrapper for the Chef cookbook "jenkins" at
# https://github.com/chef-cookbooks/jenkins
#


# Install Jenkins from the official jenkins-ci.org packages
node.set['jenkins']['master']['install_method'] = 'package'
