cookbook_file "/etc/apt/apt.conf" do
  source "apt/apt.conf"
  mode 0644
end
