git "/opt/easycv" do
  repository "git://github.com/NPSVisionLab/CVAC.git"
  revision 'master'
  action :sync
end

bash "build_easycv" do
  cwd /opt/easycv
  code <<-EOH
    tar zxf easycv.tar.gz
    cd EasyCV
    mkdir build
    cd build
    cmake ..
    make
    sudo make install
  EOH
  creates "/usr/local/bin/easycv"
end
