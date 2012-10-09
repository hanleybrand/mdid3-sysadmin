Introduction
------------

Is there a need for an introduction? Probably.

> This guide is based on building a development or testing environment
> for [MDID3][] on a virtual machine (e.g Virtual Box, VMware, etc.) and
> should not be used as a guide to set up a production server as several
> steps are specifically great ideas for goofing around locally but bad
> ideas for hosting a server. Ok, good. That’s out of the way, let’s
> have fun!
>
> 
> PS: You may find [Useful Ubuntu Utterances][] & the [Using mdid3
> ubinstall scripts][] pages useful or interesting.

Build the Foundation
--------------------


Setup a virtual machine, and install Ubuntu 10.0.4, choosing LAMP
configuration during the install.

-   Specify 64-bit / Ubuntu 64-bit to skip vmware’s “easy install”
-   You will eventually want to be able to network from your host
    machine to the vm, so setting up Bridged networking is preferable
-   If you are on a mac or otherwise prefer using a shell on your host
    machine, you may find it easier to also include “OpenSSH server” as
    an install option, so you can ssh to the vm
-   Create an admin account (this document uses mdid3admin as the user
    name)


Install Git (non-optional)

    sudo apt-get install git-core


Create MDID utility account (this allows mdid3 to run programs on it’s
own behalf)

    sudo adduser mdid


Add your admin account (not the mdid utility account) to the staff group

    sudo nano /etc/group

Find the following line and append your username (not mdid)

    staff:x:50:

> it will look like this when you’ve done it
>
>     staff:x:50:mdid3admin:
>
> (**ctrl-x** will exit, prompting you to "*save modified buffer*" (i.e.
> the file you have open) - type “y” and the return/enter key to save
> before exiting )


Log out of the command line and log back in

* * * * *

apt-get & easy-install Dependencies
-----------------------------------


First, make sure your installation is up to date

    sudo apt-get -y upgrade && install


Install additional Ubuntu software needed to run mdid (aka dependencies)
with apt-get

    sudo apt-get install openjdk-6-jre-headless python-setuptools libjpeg62-dev /
    unixodbc unixodbc-dev freetds-dev tdsodbc python-dev libmysqlclient16-dev /
    python-ldap python-memcache memcached libapache2-mod-wsgi g++ mysql-server


Install python packages with easy-install

    sudo easy_install pyodbc mysql-python pil python-dateutil flickrapi werkzeug reportlab



* * * * *

Download and Install MDID3
--------------------------


Create the directory where MDID3 will be installed

    sudo mkdir /var/local/mdid
    sudo chown mdid /var/local/mdid
    sudo chmod 775 /var/local/mdid


Git MDID3!

    cd /var/local/mdid  git init   
    git remote add rooibos git://github.com/cit-jmu/rooibos.git   
    git fetch rooibos   
    git merge rooibos/master
    sudo chown -R mdid:staff /var/local/mdid/*



This step may not be necessary

    sudo chown -R mdid:staff /var/local/mdid/*

Setup the database
------------------


    nano mdid.sql

and type this text in

    CREATE DATABASE rooibos CHARACTER SET utf8;
     GRANT ALL PRIVILEGES ON rooibos.* TO rooibos@localhost
       IDENTIFIED BY 'rooibos';
     UPDATE mysql.user SET Select_priv='Y',Insert_priv='Y',
       Update_priv='Y',Delete_priv='Y',Create_priv='Y',
       Drop_priv='Y',Index_priv='Y',Alter_priv='Y'
       WHERE Host='localhost' AND User='rooibos';
     FLUSH PRIVILEGES;
     \q

and then run the script with mysql

    mysql -u 'root' -p < mdid.sql

type the following two commands at /var/local/mdid/rooibos :

    python manage.py syncdb --noinput
    python manage.py createcachetable cache

    Configure Apache & mod_wsgi 
    The developers of django recommend using a seperate webserver for static files on a production system
    See How to use Django with Apache and mod_wsgi for more information
    Edit /etc/apache2/httpd.conf:
    sudo cp /var/local/mdid/dist/linux/httpd.conf /etc/apache2/httpd.conf


and add this line

    WSGIScriptAlias / /var/local/mdid/rooibos/dist/linux/django.wsgi

> *note*: the lone forward slash is not a typo - the first “/” indicates
> that mdid will be the root o TRUNCATED! Please download pandoc if you
> want to convert large files.

  [MDID3]: https://github.com/cit-jmu/rooibos
  [Useful Ubuntu Utterances]: https://github.com/hanleybrand/mdid3-ubinstall/wiki/Useful-Ubuntu-Utterances
  [Using mdid3 ubinstall scripts]: https://github.com/hanleybrand/mdid3-ubinstall/wiki/Using-mdid3-ubinstall-scripts
