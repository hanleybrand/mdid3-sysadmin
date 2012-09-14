
#data base section
#echo '==== Readying database user - enter mysql root pass when asked ====' 

#echo "mysql  -u 'root' -p < mdid3.sql 2> errors/mysql-errors.txt"
#mysql  -u 'root' -p < 3_mdid3.sql 2> errors/mysql-errors.txt

echo '====installing MDID 3 ====' 
# git some mdid3

echo 'cd /var/local/mdid'
cd /var/local/mdid
echo 'sudo git init'
sudo git init
echo 'sudo git remote add rooibos git://github.com/cit-jmu/rooibos.git'
sudo git remote add rooibos git://github.com/cit-jmu/rooibos.git
echo 'sudo git fetch rooibos'
sudo git fetch rooibos
echo 'sudo git merge rooibos/master'
sudo git merge rooibos/master
echo 'sudo chown -R mdid:staff /var/local/mdid/*'
sudo chown -R mdid:staff /var/local/mdid/*

echo '==== preparing webserver ===='

#copy the apache.conf file to the right place
echo 'sudo cp ~/mdid3-ubinstall/mdid3vm.conf /etc/apache2/httpd.conf'
sudo cp ~/mdid3-ubinstall/mdid3vm.conf /etc/apache2/httpd.conf

# copy preconfigured settings_local.py to rooibos dir 
echo 'sudo cp ~/mdid3redhat/settings_local.py /var/local/mdid/rooibos/settings_local.py'
sudo cp ~/mdid3-ubinstall/settings_local.py /var/local/mdid/rooibos/settings_local.py
echo "=====don't forget to double check your settings_local.py!====="
# 

# commented out #
#echo 'cd /var/local/mdid/rooibos'
#cd /var/local/mdid/rooibos
#echo 'sudo python manage.py syncdb --noinput'
#sudo python manage.py syncdb --noinput
#echo 'sudo python manage.py createcachetable cache'
#sudo python manage.py createcachetable cache
#
#echo 'sudo /etc/init.d/apache2 reload'
#sudo /etc/init.d/apache2 reload

