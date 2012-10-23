It's [better](http://stackoverflow.com/questions/9337149/is-virtualenv-recommended-for-django-production-server) (and frankly super [easy](http://code.google.com/p/modwsgi/wiki/VirtualEnvironments)) to use a virtual environment for your server's python stuff. For [hosting mdid3](https://github.com/hanleybrand/mdid3-sysadmin/), it carries at least these benefits:

1.  Allows the mdid-application user (referred to as ```mdid```) to manage python without having to use sudo
1.  Protects your mdid installation from a unwitting system wide upgrade to django 1.4 hosing your server
1.  Removes the need to type python26 in front of everything (rhel 5)

Here's how to set it up - this can be done whether you've already setup or not

## if you already have a server

It's not a problem to set up retroactively. Before you begin, install yolk:

    [sudo] easy_install yolk

and after that completes, you type

    yolk -l 

and you should get a list of the libraries you had installed anyway:

```
MySQL-python    - 1.2.3c1      - active 
PIL             - 1.1.7        - active 
Pygments        - 1.4          - active 
Python          - 2.6.5        - active development (/usr/lib/python2.6/lib-dynload)
Werkzeug        - 0.8.2        - active 
distribute      - 0.6.10       - active 
flickrapi       - 1.2          - active 
pyodbc          - 3.0.3        - active 
python-dateutil - 2.0          - active 
python-ldap     - 2.3.12       - active 
python-memcached - 1.43         - active 
reportlab       - 2.5          - active 
setuptools      - 0.6c11       - active 
virtualenv      - 1.5.1        - active 
wsgiref         - 0.1.2        - active development (/usr/lib/python2.6)
yolk            - 0.4.3        - active 
```

which you can use to make sure you put all of your dependencies in your virtualenv. Speaking of virtualenv...

## Install virtualenv

    easy_install virtualenv
   
 **note-if setting up an rhel server, you need to install python26 & setuptools first ([walkthrough](http://bda.ath.cx/blog/2009/04/08/installing-python-26-in-centos-5-or-rhel5/)) and use easy_install with python26, i.e.**

>     sudo python26 /usr/lib/python2.6/site-packages/easy_install.py virtualenv


## Create a virtualenv for mdid3

Once installed, make a directory for storing your virtualenv - if you've installed mdid to /var/local/mdid consider putting your virtualenv in /var/local/virt to keep things close, but remember to chown/chgrp the directory so the user ```mdid``` can use it

```
sudo mkdir /var/local/virt
sudo chown mdid:staff virt
virtualenv-2.6 -v --no-site-packages virt/mdid3 
```

Ok, so now all you have to do is switch to the virtualenv:

    source /var/local/virt/mdid3/bin/activate

and your terminal prompt should go from ```$``` to this: ```(mdid3)$```  (if your prompt is just ```$```)

To switch back to your default system python, just type ```deactivate``` and you'll be back to normal. 

### bash tip

Add this to your ```.bash_profile``` to activate by typing ```mdid3```:

    alias mdid3='source /var/local/virt/mdid3-py26/bin/activate'

then type

    source ~/.bash_profile

to activate your new command. 

# WAIT! STOP! HOLD ON!

Before you activate (just type ```deactivate``` if you already did) you want to make an install file for re-getting your python libraries:

    pip freeze > /var/local/virt/mdid3-py26/mdid-dep.txt

If you have an already working mdid3 server this will generate a file containing something like:

```
MySQL-python==1.2.3c1
PIL==1.1.7
Pygments==1.4
Werkzeug==0.8.2
distribute==0.6.28
flickrapi==1.2
pyodbc==3.0.3
python-dateutil==2.0
python-ldap==2.3.12
python-memcached==1.43
reportlab==2.5
virtualenv==1.5.1
wsgiref==0.1.2
yolk==0.4.3
```

You can probably delete the ```virtualenv==1.5.1``` line, but otherwise this should be good. 

Now activate 

    source /var/local/virt/mdid3-py26/bin/activate

or

    mdid3

(if you listened to my advice about adding the alias to your bash shell)

## Re-get your python libraries

This is awesome =)

1. ```pip install -r mdid-dep.txt```
2. Sip coffee
 