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
cd playbooks
ansible galaxy -m ping
ansible-playbook -K install_docker.yaml
ansible-playbook -K install_anaconda.yaml

## TIPS ##
# To fix problem with sudo apt-get update
# sudo rm -rf /var/lib/apt/lists/*
# sudo apt-get update

# To fix Docker start problem
# edit /home/xfu/.ansible/roles/mongrelion.docker/defaults/main.yml
# Change 
# storage-driver: devicemapper
# To
# storage-driver: overlay2

# To add the anaconda python onto the front of your path.
# edit /home/xfu/.ansible/roles/andrewrothstein.anaconda/defaults/main.yml
# Change 
# anaconda_make_sys_default : False
# To
# anaconda_make_sys_default : True

# Don't need to remove curl, 
# comment out the following section in /home/xfu/.ansible/roles/andrewrothstein.anaconda/tasks/main.yml
#- name: remove conda-curl since it conflicts with the system curl
#  become: yes
#  become_user: root
#  command: '{{anaconda_conda_bin}} remove -y curl'
#  args:
#    removes: '{{anaconda_link_dir}}/lib/libcurl.a'

## install Anaconda Enviroment
. export_conda_env.sh
ansible-playbook -K install_conda_env.yaml
