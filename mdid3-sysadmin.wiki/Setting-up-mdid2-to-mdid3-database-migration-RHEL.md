> **NOTE:** These directions require freetds and unixODBC  
> (e.g. sudo yum install unixODBC -y) 

These instructions were written for RHEL 5.5 systems, but will likely work on most systems that can install unixODBC and freetds. Additionally, the mdid2 database being connected to is running on MSSQL. 

### Step 1
edit  /etc/freetds.conf to add (on my system it was /etc/freetds.conf)

    [mdid2]
        host = mdid2.database.server.edu
        port = 1433
        tds version 7.2

test with

    tsql -S mdid2 -U dbusername -P dbpassword


### Step 2
edit /etc/odbcinst.ini to add the FreeTDS driver:

    [FreeTDS]
        Description     = FreeTDS
        Driver          = /usr/lib/libtdsodbc.so
        Setup           = /usr/lib/libtdsS.so
        UsageCount	= 1

test with

    osql -S mdid2 -U dbusername -P dbpassword


### Step 3
edit 	/etc/odbc.ini

    [FreeTDS_MDID2]
        Driver		 = FreeTDS
        Description	 = MDID2 Production DB
	Trace		 = Yes
	Server 		 = mdid2.database.server.edu
	Port          	 = 1433
	Database         = DBNAME
	TDS_Version      = 7.2  # for SQL Server 2005

test with 

    isql FreeTDS_MDID2 dbusername dbpassword -v


### Step 4
finally test with 

    python26    
> note, on redhat rhel 5 you need to install python26, because yum and other system tools rely on the system python (2.4 !$%$#!)

    >>> import pyodbc
    >>> cnxn = pyodbc.connect('DSN=FreeTDS_MDID2;UID=dbusername;PWD=dbpassword')

No error likely means you're good to set up to run [mdid2migrate](https://sites.jmu.edu/mdidhelp/installation/upgrading-from-mdid2). 

### Step 5

In your [mdid.xml file on your mdid3 server](https://sites.jmu.edu/mdidhelp/installation/upgrading-from-mdid2) you can use the following database configuration, using the CUSTOM servertype:

        <database>
                <servertype>CUSTOM</servertype>
                <connection>DSN=MySQLgoogled;UID=dbusername;PWD=dbpassword</connection>
              ... etc ....
        </database>