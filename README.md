# Precision 100 Migration Framework
Data migration execution and governance framework.

## Quick Usage
```
git clone https://github.com/ennovatenow/precision-100-framework.git
./install.sh
cd ~/precision100
./init_exec.sh
./adhoc_dataflow.sh demo_migration
```

The above steps, ofcourse, assumes that the [prerequisite](#prerequisites) components are already installed and configured with their default values

### A simple demo
When executing the framework with default project as [above](#quick-usage), the simple-demo project is run. It executes a demo migration, no records are actually migrated but it serves the purpose of checking if all the [prerequisite](#prerequisites) components are installed and configured properly. 

The ['longer example'](#a-longer-example) and the ['longer longer example'](#a-longer-longer-example) examples provide more details about the working of the framework. 

The default values when installing the application is as follows,

1) ORACLE_HOME = `/usr/lib/oracle/18.3/client64/`
2) Oracle SID = `mig`
3) Oracle DBA User = `system`
4) Oracle DBA User Password = `oracle` 
5) Precision Framework Schema Owner = `precision100`
6) Precision Framework Schema Owner Password = `Welcome123`
7) Migration Project = `simple-demo`
8) Migration Template Repository URL = `https://github.com/ennovatenow/precision-100-migration-templates.git`
9) Precision Installation folder = `$HOME/precision100`


### A longer example
To-do

### A longer longer example
To-do

## Operating System Requirements
Precision 100 Framework uses the `bash` shell for most of its work. Although all development and tests of the framework is done on `linux`, the framwork should run on any operating system supporting the `bash` shell.

## Hardware requirements
The hardware requirements of Precision 100 Framework depend on the volume of data to be moved and the window within which it needs to be done. You can run the framework on a `linux` laptop with 4 cores and 4 gigs of RAM for a simple demo. 

## Software Prerequisites
The framework requires the following components to work

1) Oracle database
2) Oracle Client tools (SQL Plus / SQL Loader)
3) A `git` repository or you can use [Github](http://github.com)
4) `git` client

## Setup
### Oracle
Precision 100 Framework uses an Oracle database to stage and transform data. Oracle-XE or a docker instance can be used to demo the framework. The framework creates a Oracle user/schema named `precision100` (default, can be changed) during installation

Oracle XE documentation can be found [here](https://docs.oracle.com/cd/E17781_01/index.htm). For dockers, the following links can be useful,

1. [https://github.com/fuzziebrain/docker-oracle-xe](https://github.com/fuzziebrain/docker-oracle-xe)
2. [https://github.com/DeepDiver1975/docker-oracle-xe-11g](https://github.com/DeepDiver1975/docker-oracle-xe-11g) 


> **Note:** Oracle XE has limitations on its size and processors used among other things. Check the FAQ [here](https://www.oracle.com/database/technologies/appdev/xe/faq.html) and use appropriately.


### Oracle Client Tools
Precision100 Framework requires `sqlplus` and `sqlldr` to be installed and available.
These tools form a part of the ['Oracle Instant Client'](https://www.oracle.com/technetwork/database/database-technologies/instant-client/overview/index.html) and can be freely installed. The `basic`,`sqlplus` and the `tools` packages must be installed for the framework to work.

Once installed, note the location where the client is installed. This should be set to the value of ORACLE_HOME during the installation of the framework.

e.g In Ubuntu, Oracle Instant client version 18.3 is installed in `/usr/lib/oracle/18.3/client64/` folder. In this document whenever we refer to *ORACLE_HOME* - we mean this location

#### Configuring TNS entries
Oracle clients use entries in `$ORACLE_HOME/network/admin/tnsnames.ora` to connect to the database. Create this file if it does not exist and add connection string relevant to your Oracle database.

e.g. To connect to an instance of Oracle XE running in a local machine and port 49161

```
MIG = (DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 49161))) (CONNECT_DATA = (SID = xe)))
```

Now you should be able to connect to the database as follows
 
```
sqlplus precision100/Welcome123@mig
```



### Git Repository 
Precision100 framework data templates are stored in `git` repositories. This repository can be hosted online like the [precision-100-migration-templates](https://github.com/ennovatenow/precision-100-migration-templates.git) on GitHub or hosted on premise within the network using Gitlab or any other `git` server.

We can also use a docker image to try out the framework. A guide to installing GitLab using docker can be found [here](https://docs.gitlab.com/ee/install/docker.html)

### Git Client
To install the `git` client,
```
sudo apt-get update
sudo apt-get install git
git --version
```

[Here](https://www.atlassian.com/git/tutorials/install-git) is a good article to install `git` on other platforms



## Contributing
Thank you very much for considering to contribute!

Please make sure you follow our [Code Of Conduct](CODE_OF_CONDUCT.md) and we also strongly recommend reading our [Contributing Guide](CONTRIBUTING.md).

