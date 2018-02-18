# -*- mode: ruby -*-
# vi: set ft=ruby :


if !Vagrant.has_plugin?("vagrant-proxyconf")
	abort("You have not installed the vagrant-proxyconf plugin")
end


Vagrant.configure("2") do |config|
	# Define VMs with static private IP addresses, vcpu, memory and vagrant-box.
	boxes = [
		{
			:name => "ansible-host",
			:os => 'CentOS',
			:box => "centos/7",
			:ram => 2048,
			:vcpu => 2,
			:ip => "192.168.29.92"
		}
	]

	# Provision each of the VMs.
    boxes.each do |opts|
      config.vm.define opts[:name] do |config|
        # For some reason, we are disabling the synced folder:
        #config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true

        if ENV["http_proxy"]
          #puts "http_proxy: " + ENV["http_proxy"]
          config.proxy.http     = ENV["http_proxy"]
        end
        if ENV["https_proxy"]
          #puts "https_proxy: " + ENV["https_proxy"]
          config.proxy.https    = ENV["https_proxy"]
        end
        config.proxy.no_proxy = "127.0.0.1"
    
        config.ssh.insert_key = false
        
        # Assign the box details (source, hostname, CPU count etc)
        config.vm.box = opts[:box]
        #config.vm.box_url = opts[:url] 
        config.vm.network :private_network, ip: opts[:ip]
        config.vm.provider :virtualbox do |v|
          v.memory = opts[:ram]
          v.cpus = opts[:vcpu]
          v.gui = false
        end		

        # Proxy values are set by the environment variables, and override anything specified here
        config.proxy.enabled = true

        if opts[:name] == "ansible-host"
          config.vm.provision :shell, path: "install_ansible.sh"
          config.vm.provision "ansible_local" do |ansible|
            ansible.verbose = "vv"
            ansible.extra_vars = "GUID=0fc7"
            ansible.playbook = "setup.yml" 
          end    
            
          #config.vm.provision :shell, path: "ultralight_install.sh"
          # config.vm.provision "ansible_local" do |ansible|
          #   ansible.verbose = "vv"
          #   ansible.playbook = "ultralight_install.yml"
          #   ansible.vault_password_file = "bananas"
          #   ansible.skip_tags = "hardware_check"
          #   ansible.galaxy_roles_path = "/home/vagrant/git/dao_ultralight_build/roles"
          #   ansible.inventory_path = "hosts.ini"
          
        #end
        
      end
		end
	end
end
