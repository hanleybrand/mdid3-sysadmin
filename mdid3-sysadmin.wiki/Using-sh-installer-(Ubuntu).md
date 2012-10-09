Since this project is specifically for installing on ubuntu, I feel like I don't need to say these scripts might not work on other unix platforms. But if you try them in a place where they don't work, you know that already. 

###Start with a fresh 10.0.4 Lucid Lynx vm 
(choose LAMP and OpenSSH server as install options for convenience) and in the home directory of your non-root user (I made it mdid3admin and used 'mdid' as the password for everything, but only for local development).  You'll want to know the passwords you set for root and mysql root before beginning. 

###Install Git (non-optional)

```
    sudo apt-get install git-core
```

###Clone the mdid3 install script repo from github:

```
git clone git://github.com/hanleybrand/mdid3-ubinstall.git
```

###Make the scripts executable
```    
chmod 755 *.sh
```

###Run step 1

```    
sudo ./1_mdid3.sh
```

... you'll have to type a password for the mdid user, and hit return through the rest of the prompts

####When prompted to logout, do so and then log back in

You should see a file "groupBackup.txt" in your home directory. This is awesome, let's continue. 

###Run step 2

```    
sudo ./2_mdid3.sh
```

Grab a coffee or something, this will take a few minutes, mainly because it's going to install quite a few packages, and update what's already installed. 

2_mdid3.sh will make a directory called errors and log errors to a text file in there. It also will make 0kb text files for things that didn't error, so... yeah. Do this:

```
ls -al
```

and look at the column that is 4096 for root and mdid3admin - it should be 0 for most other things. Any column that has an odd (as in unusual, i.e. not a power of 2, numbers like say '4112' for example) number is errors. In case you haven't guessed, the column is the size column.   

###Reboot

```
sudo reboot
```

and then on re-login 

###Run step 3

```    
sudo ./3_mdid3.sh
```

You now have a working, empty mdid3 installation. Congrats. 
