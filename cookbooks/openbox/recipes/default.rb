## openbox

user = node[:openbox][:user]

cookbook_file "/home/#{user}/.xinitrc" do
  owner "#{user}"
  group "#{user}"
  source "xinitrc"
  backup false
  mode "0664"
end

cookbook_file "/home/#{user}/.bash_profile" do
  owner "#{user}"
  group "#{user}"
  source "bash_profile"
  backup false
  mode "0664"
end

cookbook_file "/home/#{user}/cairo-dock_configuration.zip" do
  owner "#{user}"
  group "#{user}"
  source "cairo-dock_configuration.zip"
  backup false
  mode "0664"
end

["/home/#{user}/.config/", "/home/#{user}/.config/openbox/"].each do |dir|
  directory dir do
    owner "#{user}"
    group "#{user}"
    mode 00755
    recursive true
    action :create
  end
end

["/home/#{user}/.config/cairo-dock"].each do |dir|
  directory dir do
    owner "#{user}"
    group "#{user}"
    mode 00755
    recursive true
    action :create
  end
end

script "install_openbox" do
  interpreter "bash"
  user "root"
  cwd "/tmp/"
  code <<-EOH
  sudo apt-get -y --no-install-recommends install xserver-xorg xinit openbox xterm

  sudo apt-get install -y cairo-dock

  cp -R /etc/xdg/openbox/* /home/#{user}/.config/openbox
  unzip /home/#{user}/cairo-dock_configuration.zip -d /home/#{user}/.config/cairo-dock
  EOH
end

cookbook_file "/home/#{user}/.config/openbox/menu.xml" do
  owner "#{user}"
  group "#{user}"
  source "menu.xml"
  backup false
  mode "0664"
end
