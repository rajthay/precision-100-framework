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

1. ORACLE_HOME=/usr/lib/oracle/18.3/client64/
2. Oracle SID = mig
3. Oracle DBA User (user who creates the `precision100` schema/user) = system
4. Oracle DBA User Password = oracle (default value when installing Oracle XE)
5. Precision Framework Schema Owner = precision100
6. Precision Framework Schema Owner Password = Welcome123
7. Migration Project = simple-demo
8. Migration Template Repository URL = https://github.com/ennovatenow/precision-100-migration-templates.git
9. Precision Installation folder = $HOME/precision100

### A simple demo
When executing the framework with default project as [above](#quick-usage), the simple-demo project is run. It executes a demo migration, no records are actually migrated but it serves the purpose of checking if all the prerequisite components are installed and configured properly. The ['longer example'](#a-longer-example) and the 'longer longer example' examples provide more details for configuring the framework for proper usage.

Default configuration of the framework, expects that there is an Oracle schema with the name `precision100` and password `Welcome123` in an Oracle instance with SID: `mig`.


### A longer example
If you have an Oracle instance, you can customize the schema and passwords. Customize the following script to your needs.

```
CREATE USER precision100 IDENTIFIED BY "Welcome123"; 
GRANT CONNECT TO precision100;
GRANT CONNECT, RESOURCE, DBA TO precision100;
GRANT CREATE SESSION TO precision100;
GRANT ALL PRIVILEGE TO precision100;
GRANT UNLIMITED TABLESPACE TO precision100;
```

Once the schema and passwords are created, change `.env.sh` to reflect the customized attributes.

```
git clone http://localhost:50080/precision-100-migration-framework/precision-100-framework.git
cd precision-100-framework

vi .env.sh
```

Change the Oracle database connection parameters as per your requirement
```
export USERNAME=precision100
export PASSWORD=Welcome123
export SID=mig
```

Now run the following, you should be able to see 2 records in the output table.

```
./migration.sh demo_migration mock001
```


## Prerequisites
The framework requires the following components to work

1) Oracle database
2) SQL Plus
3) SQL Loader
4) git client
5) git repository
6) bash shell

## Setup
Thank you very much for considering to contribute!

## Contributing
Thank you very much for considering to contribute!

Please make sure you follow our [Code Of Conduct](CODE_OF_CONDUCT.md) and we also strongly recommend reading our [Contributing Guide](CONTRIBUTING.md).

