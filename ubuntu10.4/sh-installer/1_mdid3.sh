#!/bin/bash
#

echo '====Step 1 begins ====' 

# removed because git-core is required to get this script
#sudo apt-get install git-core

# necessary to check  if already exists? (doesn't seem to be)

sudo adduser mdid

sudo mkdir /var/local/mdid

sudo chmod 775 /var/local/mdid

# sudo nano /etc/group
# find the following line and append your username
# staff:x:50:
#  assuming mdid3admin
#
# it will look like  staff:x:50:mdid3admin

# $sed 'staff:x:50:' 'staff:x:50:mdid3admin'

sudo sed 's|staff:x:50:|&mdid3admin:|' /etc/group >tmpOut

sudo cp  /etc/group  ~/groupBackup.txt

sudo cp tmpOut /etc/group 

#  need to  logout now - add conditional?

echo '====Step 1 complete - log out and back in now====' 
