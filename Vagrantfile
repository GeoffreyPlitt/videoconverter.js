Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.provider "virtualbox" do |v|
    v.memory = 8192
    v.cpus = 2
  end

  config.vm.provision "docker"

  config.vm.provision :shell, :path => './vagrant_bootstrap.sh'

  config.vm.network :forwarded_port, host: 8080, guest: 8080

end