#
# Cookbook Name:: sass
# Recipe:: default
#
# https://github.com/jtgraphic/opscode-chef-cookbook-sass

codename = node['lsb']['codename']
case codename
when 'trusty'
  Package 'ruby'
else
  Package "rubygems"
end

Execute "gem install sass" do
    not_if "which sass"
end
