## Get your repos in order

Redhat Enterprise 5 is about stability, which is great - except almost nothing used by MDID was in the "stability" camp when RHEL 5 was solidified. A basic RHEL 5 server setup will be working against ease of installation the whole way through, but it ends up not being as bad as all that. The main point of pain is that most of the packages needed for MDID3 are either a) not available in the official red hat repos, b) are the wrong ones, or c) they are not named exactly the same as in the Debian family (which includes Ubuntu). 

So 

Assuming [EPEL](https://fedoraproject.org/wiki/EPEL) is not configured, enable it ([slightly deeper tutorial](http://linuxmoz.com/centos-epel-repo-install-tutorial/))

    sudo rpm -Uvh http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-4.noarch.rpm

Because rhel5 ships with python 2.4 (!!) and yum will break if you upgrade python to 2.6 (!#$%!@#!) it is advisable to install python26 to power django. The EPEL repo above contains python26, but not all of the other packages required for mdid3, so I used Chris Lea's repo as well: 

    rpm -Uvh http://yum.chrislea.com/centos/5/i386/chl-release-5-3.noarch.rpm

    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CHL


Then grab git-core

    sudo yum install git-core

## Setup the install

### Dependency isn't always a bad thing

I was unable to find two packages that are part of the Windows 2008 & Ubuntu instructions, but the setup I was doing (all RHEL 5, LAMPy) seems to get by without them:

* tdsodbc ( I think it's all handled by pyodbc/freetds/unixODBC )
* libmysqlclient16-dev  ( I suspect this functionality is in MySQL-python26 )

Here are the packages that need to be installed in order (TODO: this list is from my notes and needs to be tested still)

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

Alternatively, you can do them all at once:

    sudo yum install python26 python26-devel python26-setuptools java-1.6.0-openjdk \ 
    libjpeg-devel unixODBC unixODBC-devel freetds-devel  MySQL-python26 python-ldap \   
    python-memcached mod_wsgi gcc-c++ pyodbc 

### If you're installing sql on the same server
    sudo yum install mysql-server -y  


### (interlude) Configure easy_install for use with Python26

<span style="background-color:#ff3434; border: 1px solid #ccc; font-size: 13px; line-height: 19px; overflow: auto; padding: 6px 10px; border-radius: 3px;">
**Note: some of the problems this section describes can also be circumvented by [using a virtual environment](virtualenv%3A--for-the-better)**
</span>

As of this writing, if you install python26 from the Chris Lea repo, the command line easy_install will execute easy_install for Python 2.4 instead of 2.6, which is useless because Python 2.6 can't see libraries installed for 2.4 unless you muck about with links, and I don't think that's the greatest idea, unless you're more comfortable with centos/unix/multiple python installs than I am, in which case I don't know if you are reading this anyway. 

After installing python26-setuptools (see above), you can execute easy_install for python26 lie this:

    sudo python26 /usr/lib/python2.6/site-packages/easy_install.py [package-name]

which is unwieldy, so I made an alias in my bash_profile:

    cd ~
    nano .bash_profile
    
and then added this line above the section that declares the PATH:

    alias easy26='sudo python26 /usr/lib/python2.6/site-packages/easy_install.py'

Then 

## do the easy26

    easy26 python-ldap 
    easy26 pil 
    easy26 python-dateutil 
    easy26 flickrapi 
    easy26 werkzeug 
    easy26 reportlab 

or 

    easy26 python-ldap mysql-python pil python-dateutil flickrapi werkzeug reportlab



### (optional) Set up some aliases for command line ease

alias rooi='cd /var/local/mdid/rooibos/rooibos/'
alias rooilog='cd /var/local/mdid-storage/mdid-scratch/logs' 



## Configure and start apache

    sudo nano /etc/httpd/conf/httpd.conf

and then start it

    sudo /sbin/service httpd start    


### Configure ssl

### Generate an ssl key & request

These are the commands that worked for me  - the example commands given on the GlobalSign Apache/SSL page did not work for me. You may need to change these based on your specific IT environment (for whatever reason, -out as an arg did not work, but > did /shrug) - and for a testing environment you could just generate your own certificate. 

Note: change "mdid.university.edu" to the fully qualified domain name of your mdid server 

    sudo mkdir /etc/httpd/conf/ssl.key /etc/httpd/conf/ssl.csr /etc/httpd/conf/ssl.crt 

    sudo openssl genrsa 2048 > mdid.university.edu.key
    sudo openssl req -new -key /etc/httpd/conf/ssl.key/mdid.university.edu.key -out \   
    /etc/httpd/conf/ssl.csr/mdid.university.edu.csr

Submit the CSR to your CA with your certificate request


    

## Notes, troubles, etc.

## Redhat & Apache 

http://redhat.activeventure.com/71/referenceguide/s1-configuration-config.html

### Redhat socket errors

You need to set a non-locked down area for wsgi sockets (the default causes errors like this:

    (13)Permission denied: mod_wsgi (pid=26962): Unable to connect to WSGI \
    daemon process '<process-name>' on '/etc/httpd/logs/wsgi.26957.0.1.sock' \
    after multiple attempts. 

lock it down with this apache server directive:

    WSGISocketPrefix /var/run/wsgi



## websites I looked at while working out the install

### Generic Linux Resources

How to find files in Linux =\
http://www.codecoffee.com/tipsforlinux/articles/21.html

### Installing required packages with yum

YUM Repo for CentOS/Redhat that includes python26

http://chrislea.com/2009/09/04/yum-repository-for-centos-5/

Easy Python26 Django on Centos 5

http://chrislea.com/2009/09/09/easy-python-2-6-django-on-centos-5/comment-page-1/#comment-854

Index of Chris Lea's YUM repo

http://yum.chrislea.com/centos/5/

Another YUM repo of python26 stuff, after Chris Lea's (see http://ben.timby.com/?p=123)

http://dagobah.ftphosting.net/yum/

installing python2-6 mod_wsgi and python mysql on a centos box

http://www.tokyomuslim.com/2010/08/installing-python2-6-mod_wsgi-and-python-mysql-on-a-centos-box/

Setup python 2.5, mod_wsgi & django on CentOs

http://blog.perplexedlabs.com/2008/11/10/setup-python-25-mod_wsgi-and-django-10-on-centos-5-cpanel/

DJANGO ON CPANEL WITH PYTHON2.6, VIRTUALENV AND MOD_WSGI

http://toic.org/blog/2010/08/14/django-on-cpanel-with-python2-6-virtualenv-and-mod_wsgi/

### pyodbc - freeTDS - unixODBC  OH MY!

PyODBC, UnixODBC, FreeTDS – config (This is a great walkthrough)

http://kipb7.wordpress.com/2008/06/12/pyodbc-unixodbc-freetds-config/

FreeTDS User Guide: A Guide to Installing, Configuring, and Running FreeTDS - Confirm the installation

http://www.freetds.org/userguide/confirminstall.htm

FreeTDS User Guide - Connection attributes

http://www.freetds.org/userguide/odbcconnattr.htm

TDS Protocol Documentation

http://www.freetds.org/tds.html

FreeTDS User Guide - Troubleshooting ODBC connections

http://www.freetds.org/userguide/odbcdiagnose.htm#WITH.UNIXODBC

django-pyodbc project home

http://code.google.com/p/django-pyodbc/

pyodbc connection strings

http://code.google.com/p/pyodbc/wiki/ConnectionStrings

unixODBC

http://www.unixodbc.org/

ODBC with Python (pyodbc) to MS SQL (SQL Server - Microsoft)

http://dgtlmoon.com/odbc_with_python_pyodbc_to_ms_sql_sql_server_microsoft

SQLConnect Function

http://msdn.microsoft.com/en-us/library/windows/desktop/ms711810(v=vs.85).aspx

### MySQL

MySQL error: 2013, “Lost connection to MySQL server at 'reading initial communication packet', system error: 0”

http://stackoverflow.com/questions/3578147/mysql-error-2013-lost-connection-to-mysql-server-at-reading-initial-communic

Looping recursion (unixODBC threads)

http://loopingrecursion.com/index.php?t=unixodbc

### Apache config

Apache - default layouts between distros (shows where the config files, error logs, etc are per platform)

http://wiki.apache.org/httpd/DistrosDefaultLayout


### Apache/mod_wsgi

I almost followed Jesse down the virtualenv path - and may yet still

http://jessenoller.com/2009/07/24/django-mod_wsgi-apache-and-os-x-do-it/

WSGI tutorial (not for django)

http://webpython.codepoint.net/wsgi_tutorial

Apache permission denied on logs directory

http://www.linuxquestions.org/questions/linux-server-73/apache-permission-denied-error-log-793102/

wsgi configuration issues

http://code.google.com/p/modwsgi/wiki/ConfigurationIssues


### Apache/SSL

http://onlamp.com/onlamp/2008/03/04/step-by-step-configuring-ssl-under-apache.html

http://tldp.org/HOWTO/SSL-RedHat-HOWTO-3.html