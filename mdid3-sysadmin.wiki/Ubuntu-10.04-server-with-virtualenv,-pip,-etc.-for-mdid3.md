##Turn on the LAMP
We're making a LAMP (Linux Apache MySQL Python in this case) vm image to test/develop MDID3. Ok, let's got from a no-frills Ubuntu 10.04 Server 64 vmware install - first:

    sudo apt-get install openssh-server

When that's done, especially if you're on a mac, do yourself a favor and hide vmware and open Terminal.app which supports, among other things, copy/paste! 0.o

Oh wait, before you can ssh to the vm, you need to grab an IP address for it:

    sudo ifconfig

Should get you an IP address in the eth0 section (with the label "inet addr")

Check python

    python -V

It should come back with 2.6.5.  If not, did you really install Ubuntu 10.4?

Ok, We've got L**P. Let's grab some *MP* and get to business!

    sudo apt-get install apache2

That's apache, so we're at LA_P. If you're working with a terminal only vm, you can test Apache by pointing a browser on your host machine at http://{ifconfig_results} - http://localhost will connect to the web server on your host machine, not the vm. 

Now, lets get SQLing!

    sudo apt-get install mysql-server

You'll be prompted for a sql root password.  If you're really doing a vm image for testing, I'd make a really short easy to remember password the password for everything. If you're setting up a server, proper password procedures, please!

Then let's finish up the apt-get stuff for completeness:

    sudo apt-get install openjdk-6-jre-headless python-setuptools \
    libjpeg62-dev unixodbc unixodbc-dev freetds-dev tdsodbc python-dev \
    libmysqlclient16-dev python-ldap python-memcache memcached \
    libapache2-mod-wsgi g++ mysql-server curl git-core

##Entering the hotness

Ok, let's follow the advice of Salty Crane and setup a virtualenv.  First, we're going to need some basic python tools (including easy_install)

    sudo apt-get install python-setuptools python-dev build-essential

Nice, now let's get pip, which is kind of like the "other" easy_install:

    sudo easy_install -U pip

and then use pip to get virtualenv:

    sudo pip install -U virtualenv

we'll install distribute for the new hotness:

    sudo curl -0 http://python-distribute.org/distribute_setup.py >> distribute_setup.py

    sudo python distribute_setup.py

Wait, why are we doing this?  Well, "[t]he basic problem being addressed is one of dependencies and versions, and indirectly permissions." Also, you won't have to type sudo in front of everything.  If that isn't good enough for you, go read [what it does](http://www.virtualenv.org/en/latest/#what-it-does) =)

Let's continue!

    sudo mkdir -p /srv/python-environments

then

    sudo virtualenv --no-site-packages --distribute mdid3



##References:

https://help.ubuntu.com/10.04/serverguide/C/index.html

http://www.howtoforge.com/ubuntu_lamp_for_newbies

http://www.saltycrane.com/blog/2009/05/notes-using-pip-and-virtualenv-django/