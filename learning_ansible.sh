mkdir playbooks
cd playbooks
vagrant init ubuntu/trusty64
vagrant up

# To output the SSH connection details
vagrant ssh-config

# To test Ansible can connect to the server
ansible testserver -i hosts -m ping

# With ansible.cfg file
ansible testserver -m ping

# run arbitrary commands on remote machines with command module
ansible testserver -m command -a pwd

# command module is the default module
ansible testserver  -a pwd

# if command contains spaces
ansible testserver -a "tail /var/log/dmesg"

# if need root access
ansible testserver -b -a "tail /var/log/syslog"

# install Nginx
ansible testserver -b -m apt -a "name=nginx update_cache=yes"

# restart Nginx
ansible testserver -b -m service -a "name=nginx state=restarted"


source ansible/bin/activate
ansible galaxy -m ping
ansible-playbook -K install_docker.yaml

# To fix problem with sudo apt-get update
# sudo rm -rf /var/lib/apt/lists/*
# sudo apt-get update

# To fix Docker start problem
# edit /home/xfu/.ansible/roles/mongrelion.docker/defaults/main.yml
# Change 
# storage-driver: devicemapper
# To
# storage-driver: overlay2

