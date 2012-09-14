#!/bin/bash
#

echo '====Step 2  begins ====' 
#make dir for error reports just incase
echo 'mkdir errors'
mkdir errors

echo 'updating Ubuntu first'
echo 'apt-get update -y'
sudo apt-get update -y   
echo 'apt-get upgrade -y'
sudo apt-get upgrade -y


# 2> send errors to a text file in the errors dir, -y says "yes" to questions
echo 'apt-getting...'
sudo apt-get install openjdk-6-jre-headless -y 2> errors/openjdk-6-jre-headless-errors.txt
sudo apt-get install python-setuptools -y 2> errors/python-setuptools-errors.txt
sudo apt-get install libjpeg62-dev -y  2> errors/libjpeg62-errors.txt
sudo apt-get install unixodbc -y  2> errors/unixodbc-errors.txt
sudo apt-get install unixodbc-dev -y  2> errors/unixodbc-dev-errors.txt
sudo apt-get install freetds-dev -y  2> errors/freetds-errors.txt
sudo apt-get install tdsodbc -y  2> errors/tdsodbc-errors.txt
sudo apt-get install python-dev -y  2> errors/python-dev-errors.txt
sudo apt-get install libmysqlclient16-dev -y  2> errors/libmysqlclient16-errors.txt
sudo apt-get install python-ldap -y  2> errors/python-ldap-errors.txt
sudo apt-get install python-memcache -y  2> errors/python-memcache-errors.txt
sudo apt-get install memcached -y  2> errors/memcached-errors.txt
sudo apt-get install libapache2-mod-wsgi -y  2> errors/libapache2-mod-wsgi-errors.txt
sudo apt-get install g++  -y 2> errors/g++-errors.txt
sudo apt-get install mysql-server -y  2> errors/mysql-server-errors.txt
echo 'easy-installing...'
sudo easy_install pyodbc 2> errors/pyodbc-errors.txt
sudo easy_install mysql-python 2> errors/pyodbc-errors.txt
sudo easy_install pil 2> errors/pyodbc-errors.txt
sudo easy_install python-dateutil 2> errors/pyodbc-errors.txt
sudo easy_install flickrapi 2> errors/pyodbc-errors.txt
sudo easy_install werkzeug 2> errors/pyodbc-errors.txt
sudo easy_install reportlab 2> errors/pyodbc-errors.txt


echo '============== apt-get & easy_install complete =============='
echo '================ please check for errors and ================'
echo '=============== execute 3_mdid.sh  when ready ==============='