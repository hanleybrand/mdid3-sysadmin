#!/bin/bash
#

echo '====Step 2  begins ====' 
#make dir for error reports just incase
echo 'mkdir errors'
mkdir errors

# need to look into this

#echo 'updating RHEL first'
#echo 'yum update -y'
#sudo yum update -y   
#echo 'yum upgrade -y'
#sudo yum upgrade -y


# 2> send errors to a text file in the errors dir, -y says "yes" to questions
echo 'yum...'
sudo yum install openjdk-6-jre-headless -y 2> errors/openjdk-6-jre-headless-errors.txt

	sudo yum install python26 -y 2> errors/python26.txt
	sudo yum install python26-devel -y  2> errors/python26-devel.txt
	sudo yum install python26-setuptools -y 2> errors/python26-setuptools.txt
	sudo yum install java-1.6.0-openjdk  -y 2> errors/java-1.6.0-openjdk.txt
	sudo yum install libjpeg-devel -y 2> errors/libjpeg-devel.txt
	sudo yum install unixODBC -y 2> errors/unixODBC.txt
	sudo yum install unixODBC-devel -y 2> errors/unixODBC-devel.txt
	sudo yum install freetds-devel -y  2> errors/freetds-devel.txt
	sudo yum install MySQL-python26 -y 2> errors/MySQL-python26.txt
	sudo yum install python-ldap -y 2> errors/python-ldap.txt
	sudo yum install memcached -y 2> errors/memcached
	sudo yum install python-memcached -y 2> errors/python-memcached.txt
	sudo yum install mod_wsgi -y 2> errors/mod_wsgi.txt
	sudo yum install gcc-c++  -y 2> errors/gcc.txt
	sudo yum install pyodbc -y 2> errors/pyodbc.txt

echo 'easy-installing...'
sudo easy_install pyodbc 2> errors/pyodbc-errors.txt
sudo easy_install mysql-python 2> errors/pyodbc-errors.txt
sudo easy_install pil 2> errors/pyodbc-errors.txt
sudo easy_install python-dateutil 2> errors/pyodbc-errors.txt
sudo easy_install flickrapi 2> errors/pyodbc-errors.txt
sudo easy_install werkzeug 2> errors/pyodbc-errors.txt
sudo easy_install reportlab 2> errors/pyodbc-errors.txt


echo '============== yum & easy_install complete =============='
echo '================ please check for errors and ================'
echo '=============== execute 3_mdid.sh  when ready ==============='