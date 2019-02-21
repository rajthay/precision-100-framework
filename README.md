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
 
The default values when installing the application is as follows,

1. ORACLE_HOME = `/usr/lib/oracle/18.3/client64/`
2. Oracle SID = `mig`
3. Oracle DBA User = `system`

   This user is used create the precision 100 schema/user. It is used only during installation and is never stored.
4. Oracle DBA User Password = `oracle` 

   The password for the user in 3 above. It is used only during installation and is never stored.
5. Precision Framework Schema Owner = `precision100`
6. Precision Framework Schema Owner Password = `Welcome123`
7. Migration Project = `simple-demo`
8. Migration Template Repository URL = `https://github.com/ennovatenow/precision-100-migration-templates.git`
9. Precision Installation folder = `$HOME/precision100`

### A simple demo
When executing the framework with default project as [above](#quick-usage), the simple-demo project is run. It executes a demo migration, no records are actually migrated but it serves the purpose of checking if all the [prerequisite](#prerequisites) components are installed and configured properly. 

The ['longer example'](#a-longer-example) and the ['longer longer example'](#a-longer-longer-example) examples provide more details about the working of the framework. 

### A longer example
To-do

### A longer longer example
To-do

## Prerequisites
The framework requires the following components to work

1) Oracle database
2) Oracle Client tools (SQL Plus / SQL Loader)
3) A `git` repository or you can use [Github](http://github.com)
4) `git` client

## Setup
### Oracle
If you have an Oracle instance then you can

### Oracle Client Tools
Precision100 Framework requires `sqlplus` and `sqlldr` to be installed and available.
These tools form a part of the ['Oracle Instant Client'](https://www.oracle.com/technetwork/database/database-technologies/instant-client/overview/index.html) and can be freely installed. The `basic`,`sqlplus` and the `tools` packages must be installed for the framework to work.

Once installed, note the location where the client is installed. This should be set to the value of ORACLE_HOME during the installation of the framework.

e.g In Ubuntu, Oracle Instant client version 18.3 is installed in `/usr/lib/oracle/18.3/client64/` folder. In this document whenever we refer to ORACLE_HOME - we mean this location

#### Configuring TNS entries
Oracle clients use entries in $ORACLE_HOME/network/admin/tnsnames.ora to connect to the database. Create this file if it does not exist and add connection string relevant to your Oracle database.

e.g.

```
MIG = (DESCRIPTION = (ADDRESS_LIST = (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 49161))) (CONNECT_DATA = (SID = xe)))
```

Now you should be able to connect to the database as follows

```
sqlplus precision100/Welcome@mig
```



### Git Repository 

### Git Client

## Contributing
Thank you very much for considering to contribute!

Please make sure you follow our [Code Of Conduct](CODE_OF_CONDUCT.md) and we also strongly recommend reading our [Contributing Guide](CONTRIBUTING.md).

