## Bash shell (i.e. "the command line")
### save a copy of commands you typed, to document stuff later
    history -w ~/shellHistory.txt

### get DHCP address (or see what your ip address is)
    sudo dhclient

### release DHCP address
    sudo dhclient -r

### restart apache
    sudo /etc/init.d/apache2 reload

### check apache error log
    tail -f  /var/log/apache2/error.log

### shutdown the vm
    sudo shutdown -h now

### reboot the vm
    sudo reboot

## mysql
### launch mysql as root
    mysql -u 'root' -p
### run a mysql scipt
    mysql -u 'root' -p < script.sql
### get a full list of users (launch mysql first)
   select * from mysql.user;

## Git

### install MDID3 via git (change experimental to master if desired)
```
git init
sudo git init
sudo git remote add rooibos git://github.com/cit-jmu/rooibos.git
sudo git fetch rooibos
sudo git merge rooibos/experimental
```

### update MDID3 via git (change experimental to master if desired)
```
git stash 
git fetch rooibos
git merge rooibos/experimental 
git stash pop 
```

***

## Mac commands

### Edit hosts (so you can get to your vmware server)
    sudo nano /etc/hosts

###
    sudo dscacheutil -flushcache 
