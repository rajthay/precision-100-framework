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

### Oracle Client Tools

### Git Repository 

### Git Client

## Contributing
Thank you very much for considering to contribute!

Please make sure you follow our [Code Of Conduct](CODE_OF_CONDUCT.md) and we also strongly recommend reading our [Contributing Guide](CONTRIBUTING.md).

