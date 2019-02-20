# Precision 100 Migration Framework
Data migration execution and governance framework.

## Usage
Using the Precision 100 framework is as easy as cloning the repository and executing the `migration.sh` shell script. It, ofcourse, assumes that the [prerequisite](#prerequisites) components are already installed.

### A simple demo
The following command executes a demo migration, no records are actually migrated but it serves the purpose of checking if all the prerequisite components are intalled and configured properly. The ['longer example'](http://localhost/precision-100-migration-framework/precision-100-framework#a-longer-example) and the 'longer longer example' examples provide more details for configuring the framework for proper usage.

The demo migration expects that there is an Oracle schema with the name `precision100` and password `Welcome123` in an Oracle instance with SID: `mig`.

```
git clone http://localhost:50080/precision-100-migration-framework/precision-100-framework.git
cd precision-100-framework
./migration.sh demo_migration mock001
```


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

