# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.require_version ">= 1.5.0"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

#  $box_name = "opscode_ubuntu-12.04_provisionerless"
#  $box_path = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box" 
$box_name = "ubuntu-14.10-amd64.box"
$box_path = "https://github.com/kraksoft/vagrant-box-ubuntu/releases/download/14.10/"


  # Prevent the "stdin: is not a tty" warning
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.hostname = "druid-example"

  # Set the version of chef to install using the vagrant-omnibus plugin
  config.omnibus.chef_version = :latest


  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = $box_name
  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = $box_path

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  config.vm.network :private_network, type: "dhcp"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 8081, host: 8081
  config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
   config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
     vb.customize ["modifyvm", :id, "--memory", "4096"]
   end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  # The path to the Berksfile to use with Vagrant Berkshelf
  # config.berkshelf.berksfile_path = "./Berksfile"

  # Enabling the Berkshelf plugin. To enable this globally, add this configuration
  # option to your ~/.vagrant.d/Vagrantfile file
  config.berkshelf.enabled = true

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to exclusively install and copy to Vagrant's shelf.
  # config.berkshelf.only = []

  # An array of symbols representing groups of cookbook described in the Vagrantfile
  # to skip installing and copying to Vagrant's shelf.
  # config.berkshelf.except = []

  storm_version = "0.9.4"

  config.vm.provision :chef_solo do |chef|
    chef.add_recipe "java"
#    chef.add_recipe "storm-cookbook::singlenode"

    chef.json = {
      :java => {
        :oracle => {
          "accept_oracle_download_terms" => true
        },
        :install_flavor => "openjdk",
        :jdk_version => "7",
      },

      :storm => {
        :version => storm_version,
        :deploy => {
          :user => "vagrant",
          :group => "user",
        },
        :nimbus => {
          :host => "localhost",
          :childopts => "-Xmx128m",
        },
        :supervisor => {
          :hosts =>  ["localhost"],
          :childopts => "-Xmx128m",
        },
        :worker => {
          :childopts => "-Xmx128m",
        },
        :ui => {
          :childopts => "-Xmx128m",
        },
      },
    }

    chef.run_list = [
        "recipe[druid-kafka-storm::default]",
        "recipe[golang]",
        "recipe[cerner_kafka]",
        "recipe[vim]",
        "recipe[tmux]",
        "recipe[storm-cookbook]",
        "recipe[vim]",
        "recipe[tmux]",
        "recipe[zookeeper]",
        "recipe[cerner_kafka]",
        "recipe[druid]"
    ]
  end
storm_path = "/home/vagrant/apache-storm-${storm_version}"
$script = <<SCRIPT
   sudo echo "tranquility.zk.connect: \"localhost:2181\"" >> ${storm_path}/conf/storm.yaml
SCRIPT

  config.vm.provision "shell", inline: $script  


  config.vm.synced_folder ".", "/srv/druid"
  # Require the Trigger plugin for Vagrant
  unless Vagrant.has_plugin?('vagrant-triggers')
    # Attempt to install ourself. 
    # Bail out on failure so we don't get stuck in an infinite loop.
    system('vagrant plugin install vagrant-triggers') || exit!

    # Relaunch Vagrant so the new plugin(s) are detected.
    # Exit with the same status code.
    exit system('vagrant', *ARGV)
  end

  # Workaround for https://github.com/mitchellh/vagrant/issues/5199
  config.trigger.before [:reload, :up, :provision], stdout: true do
    SYNCED_FOLDER = ".vagrant/machines/default/virtualbox/synced_folders"
    info "Trying to delete folder #{SYNCED_FOLDER}"
    begin
      File.delete(SYNCED_FOLDER)
    rescue StandardError => e
      warn "Could not delete folder #{SYNCED_FOLDER}."
      warn e.inspect
    end
  end
end
