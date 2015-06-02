## auto-login and intellij desktop icon

user = node['startup-setup']['user']

script "startup-setup" do
  interpreter "bash"
  user "root"
  cwd "/home/#{user}"
  code <<-EOH
  echo "autologin-user=#{user}" >> /etc/lightdm/lightdm.conf
  echo "autologin-user-timeout=0" >> /etc/lightdm/lightdm.conf
  passwd -d #{user}
  mkdir -p /home/#{user}/Desktop
  cp /usr/share/applications/intellij.desktop /home/#{user}/Desktop/intellij.desktop
  cp /usr/share/applications/intellij.desktop /etc/xdg/autostart
  EOH
end
