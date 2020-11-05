# Section 02: Creating a Local Linux Shell Scripting Environment

- [Section 02: Creating a Local Linux Shell Scripting Environment](#section-02-creating-a-local-linux-shell-scripting-environment)
  - [Vagrant and VirtualBox](#vagrant-and-virtualbox)
    - [VirtualBox](#virtualbox)
    - [Vagrant](#vagrant)
  - [Create Linux Shell Scripting Lab Environment](#create-linux-shell-scripting-lab-environment)
  - [Troubleshooting Tips](#troubleshooting-tips)

## Vagrant and VirtualBox

### VirtualBox

We are going to run Linux insde virual machines. The VirtualBox is one of the virtualization softwares provides full virtualization.

- Host and Guest
  - The Physical Computer running up virtualization softwares is the `host`.
  - The Virtual Computer running inside virtual machines is the `guest`.
- The guest operating systems inside virtual machines think they're using real hardware.
- VirtualBox allows the guest operating systems to access shared folders and clipboards.

<br/>
<div align="right">
  <b><a href="#section-02-creating-a-local-linux-shell-scripting-environment">[ ↥ Back To Top ]</a></b>
</div>
<br/>

### Vagrant

Vagrant is a command line tool to automate the tedious process of setting up virtual machines.

- Provides easy ways to configure reproduceable and portable work environments by default.
- Each `Box` is an operating system image in Vagrant. We can use `vagrant box add <NAME>` to using the public created image.
- Each `Vagrant Project` is a folder with a `Vagrantfile`. We can use `vagrant init <NAME>` to initialize the Vagrant project.
- We can use `vagrant up` to import the box into VirtualBox and start it. Note that the virtual machine is started in headless mode.

Useful commands of Vagrant are shown below:

```bash
# connect to specify virtual machine with SSH
$ vagrant ssh <VM NAME>

$ vagrant                   # list options
$ vagrant up <VM NAME>      # starts the VM
$ vagrant halt <VM NAME>    # stops the VM
$ vagrant resume <VM NAME>  # resumes the VM
$ vagrant destroy <VM NAME> # removes the VM
$ vagrant suspend <VM NAME> # suspends the VM
```

<br/>
<div align="right">
  <b><a href="#section-02-creating-a-local-linux-shell-scripting-environment">[ ↥ Back To Top ]</a></b>
</div>
<br/>

## Create Linux Shell Scripting Lab Environment

1. Go to [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Download Vagrant](https://www.vagrantup.com/downloads) download and install softwares in need.
2. Add the **Box** `jasonc/centos7` to Vagrant.
    ```bash
    # add the box to Vagrant
    $ vagrant box add jasonc/centos7
    ```
3. Create the vagrant project and then run Vagrant.
    ```bash
    # create project folder
    $ mkdir exercise01 && cd exercise01

    # initialize project with box and run the virtual machine
    $ vagrant init jasonc/centos7
    $ vagrant up

    # if there is any wrong, reboot the virtual machine
    $ vagrant reload
    ```
4. Confirm the running status and connect to the virtual machine
    ```bash
    # confirm the status of virtual machine
    $ vagrant status

    # connect to the virtual machine with ssh
    $ vagrant ssh

    # stop the virtual machine
    $ vagrant halt
    ```
5. Edit the `Vagrantfile` to control settings and reload virtual machine
    ```yml
    Vagrant.configure(2) do |config|
      config.vm.box = "jasonc/centos7"
      config.vm.hostname = "test"
      config.vm.network "private_network", ip: "10.9.8.7"
    end
    ```
6. Moreover, follow the steps above and create project with multi virtual machines.
    ```yml
    Vagrant.configure("2") do |config|
      config.vm.box = "jasonc/centos7"
      config.vm.define "test1" do |test1|
        test1.vm.hostname = "test1"
        test1.vm.network "private_network", ip: "10.9.8.5"
      end
      config.vm.define "test2" do |test2|
        test2.vm.hostname = "test2"
        test2.vm.network "private_network", ip: "10.9.8.6"
      end
    end
    ```

<br/>
<div align="right">
  <b><a href="#section-02-creating-a-local-linux-shell-scripting-environment">[ ↥ Back To Top ]</a></b>
</div>
<br/>

## Troubleshooting Tips

- Antivirus Conflicts
- Virtually Connect the Network Cable
- Inspect the GUI for your Virtual Machine

<br/>
<div align="right">
  <b><a href="#section-02-creating-a-local-linux-shell-scripting-environment">[ ↥ Back To Top ]</a></b>
</div>
<br/>
