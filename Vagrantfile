# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"

  # get public key
  public_key_path = File.join(Dir.home, ".ssh", "id_rsa.pub")
  if File.exist?(public_key_path)
    public_key = IO.read(public_key_path)
  end

  # get private key from the host - workaround - problem with ssh-agent on windows
  private_key_path = File.join(Dir.home, ".ssh", "id_rsa")
  if File.exist?(private_key_path)
    private_key = IO.read(private_key_path)
  end

  config.ssh.forward_agent = true
  config.ssh.keys_only = false

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "4096"
	 vb.name = "java-oca"
  end

  config.vm.provision :shell, :inline => <<-SCRIPT
    set -e

    # Add host user's ssh public key to authorized_hosts
    homedir=$(getent passwd "$SUDO_USER" | cut -d: -f6)
    echo '#{public_key}' >> $homedir/.ssh/authorized_keys
    chmod 600 $homedir/.ssh/authorized_keys

	echo '#{private_key}' > $homedir/.ssh/id_rsa
  SCRIPT

  config.vm.provision "shell", path: "sh/provision.sh", privileged: false

end
