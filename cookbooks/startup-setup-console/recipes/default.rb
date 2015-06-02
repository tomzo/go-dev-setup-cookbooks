#setting up auto login for console

user = node['startup-setup-console']['user']

script "startup-setup-console" do
  interpreter "bash"
  user "root"
  cwd "/home/#{user}"
  code <<-EOH
    sed -i -e 's#exec /sbin/getty#& --autologin #{user}#' /etc/init/tty1.conf
  EOH
end
