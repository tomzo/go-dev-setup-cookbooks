#
# Cookbook Name:: rice-developer-tools
# Recipe:: default
#
# Copyright 2012, Example Com
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

## intellij

# provision for the same use that runs this recipe
user = node[:intellij][:user]

cookbook_file "/usr/share/applications/intellij.desktop" do
  owner user
  group user
  source "ubuntu.intellij.desktop"
  backup false
  mode "0755"
end

["/home/#{user}/misc_go_files" ,"/home/#{user}/.IdeaIC13", "/home/#{user}/.IdeaIC13/config", "/home/#{user}/.IdeaIC13/config/options"].each do |dir|
  directory dir do
    owner user
    group user
    mode 00755
    recursive true
    action :create
  end
end

cookbook_file "/home/#{user}/misc_go_files/open_go_in_intellij.sh" do
  owner user
  group user
  source "open_go_in_intellij.sh"
  backup false
  mode "0755"
end

cookbook_file "/home/#{user}/misc_go_files/workspace.xml" do
  owner user
  group user
  source "workspace.xml"
  backup false
  mode "0664"
end

cookbook_file "/home/#{user}/.IdeaIC13/config/options/jdk.table.xml" do
  source "jdk.table.xml"
  owner user
  group user
  backup false
  mode "0664"
end

intellij_mirror_site = "http://download.jetbrains.com/idea/ideaIC-13.1.tar.gz"
intellij_file = "ideaIC-13.1.tar.gz"

script "install_intellij" do
  interpreter "bash"
  user "root"
  cwd "/tmp/"
  code <<-EOH
  rm -rf /opt/intellij
  mkdir /opt/intellij
  cd /opt/intellij
  wget #{intellij_mirror_site}
  tar -zxvf #{intellij_file}
  find . -maxdepth 1 -name "idea-IC*" -type d | head -1 | xargs -i sudo ln -s {} idea-IC
  rm -f ideaIC*.tar.gz
  EOH
  only_if do ! File.exists?("/opt/intellij/idea-IC/bin/idea.sh") end
end
