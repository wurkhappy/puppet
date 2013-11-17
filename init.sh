~!/bin/bash
sudo rpm -ivh http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm
yum -y install puppet
yum -y install git
mkdir .ssh
mv git-rsa .ssh/
touch .ssh/config
echo 'IdentityFile ~/.ssh/git_rsa' > .ssh/config
eval `ssh-agent -s`
ssh-add .ssh/git_rsa 
chmod 400 .ssh/git_rsa 
cd /etc/
rm -rf puppet/
git clone git@github.com:wurkhappy/puppet.git
puppet apply /etc/puppet/manifests/dbserver.pp --modulepath=/etc/puppet/modules
