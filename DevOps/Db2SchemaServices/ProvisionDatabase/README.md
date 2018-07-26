# Readme file for Db2 for z/OS "Create Database" as a Service

The service allows you to rapidly provision a database in an existing DB2
subsystem.

This readme contains the following sections:
* **Prerequisites**
* **Setting up the service**
* **`provision.xml`**
* **`deprovision.xml`**
* **`deprovision.xml`**

## Prerequisites:
1.  A DB2 subsystem has been established on the system where the provision
will take place.
2.  The workflow files have been copied from the factory location and the
`clouddb2.input` file customized for use in the local environment.
3.  The following privileges have been granted to the user specified in
the JOBCARD: CREATEDBA privilege or SYSADM authority or System DBADM authority
4.  If you are using RACF security for DB2 and using the default
`CREATERACF.jcl` to create RACF group and user, RACF profile BATCH needs to be
defined on the subsystem where the provision will take place. If you are not
using `<mvsname>`.BATCH, you will have to modify the `CREATERACF.jcl` to reflect
the RACF BATCH profile that is defined in the environment.

## Setting up the service:
The files of the service are stored in a directory in z/OS UNIX System Services (USS), and the directory including files must be accessible to z/OSMF. All the required files are packed into the pax file.

   - Download the pax file
   - Use FTP to upload the pax file in binary mode to a directory where you want to store the service in USS
   - Extract the contents of the pax file in the directory where you put the pax file 
      - pax -rvf `<the name of the pax file>`

Extracting produces the following direcotry structure:
```
    <service base direcotry>    -- all files of the service
        provision.xml           -- Workflow to provision a database
        deprovision.xml         -- Workflow to deprovision the provisioned database
        actions.xml             -- Actions of the service
        clouddb2.input          -- Sample input variable file to be customized
        CREATDB.jcl             -- JCL template to create a database
        CREATERACF.jcl          -- JCL template to permit user access to the provisioned database
        CREATETC.jcl            -- JCL template to create trusted context
        CREATETCMAP.jcl         -- JCL template to associate the distributed username with a RACF user ID
        DELETERACF.jcl          -- JCL template to delete user access
        DELETETC.jcl            -- JCL template to drop trusted context
        DELETETCMAP.jcl         -- JCL template to delete distributed identify filter
        DROPDB.jcl              -- JCL template to drop the provisioned database
        GRANTU.jcl              -- JCL template to grant user access to the provisioned database
        REVOKEU.jcl             -- JCL template to revoke user access
```
 
`provision.xml`

This is the workflow that provisions a database in an existing DB2
subsystem. The workflow consists of 5 steps. The first step is to create
a database in an existing DB2 subsystem. The second step is to add a
RACF group and a user, to grant DBADM to the group and to give
permission of running BATCH job, assuming the profile BATCH is defined
ahead, on the subsystem. The third step is to create a role with DBADM
authority of the databases created in the first step, then to create a
local and a remote trusted context with the role. This should be run
once and shared among the different instances. The fourth step is to
create a RACF map to map a distributed identity to the trusted context.
The fifth step is to assign DBADM privilege of the database to a user
the database is provisioned for. The second, third, fourth and fifth
step are optional based on the need, refer to the description of input
variable file section on how to skip a certain step in the workflow.
 
Customize the security JCLs based on your security solution, policy and
profiles before running the workflow.

The following table lists the steps and any associated JCL file:

|Step|    Description                                       |  JCL           |  Optional|
|--- |---                                                   |---             |---       |
|1   | CREATEDB  |  NO       | Create a DATABASE|
|2   | CREATERACF | YES     |  Create a RACF group and user with DBADM authority of the objects|
|3  |  CREATETC|    YES    |   Create a local and remote trusted context granting a role with DBADM authority|
|4 |   CREATETCMAP| YES  |     Create a RACF map to the trusted context|
|5|    GRANTU      |YES |      Grant DBADM authority to a user|
 

`deprovision.xml`

This is the workflow that deprovisions a database from an existing DB2
subsystem. The workflow consists of 5 steps. The first step is to revoke
the DBADM privilege from the database user that assigned to the user the
database is provisioned for. The second step is to delete the
provisioned RACF map. The third step is to delete the provisioned
trusted contexts and role. The fourth step is to delete the provisioned
RACF group and user. The first, second, third and fourth step are
optional based on the need, refer to the description of input variable
file section on how to skip a certain step in the workflow. The fifth
step is to drop the database.
 
The following table lists the steps and any associated JCL file:

|Step|    Description                                       |  JCL           |  Optional|
|--- |---                                                   |---             |---       |
|1  | Revoke DBADM authority from a user  |    REVOKEU    | YES|
|2 |  Delete RACF map of the trusted context | DELETETCMAP| YES|
|3  | Delete trusted contexts and role      |  DELETETC   | YES|
|4 |  Delete a RACF group and user          |  DELETERACF|  YES|
|5|   Drop a DATABASE                       |  DROPDB    |  NO|


The `clouddb2.input` file contains the following properties:

|Property    |Remarks|
|---         |---    |
|DSNLOAD      |       The name of the main APF-authorized DB2 load module library that is to be used by installation and sample jobs|
|MVSSNAME     |       The z/OS subsystem name for DB2, where the database will be provisioned and deprovisioned|
|RUNLIB       |       The name of the DB2 sample application load module library, where program to execute dynamic queries can be found|
|PROGNAME      |      The name of the program to execute dynamic queries, e.g. DSNTEP2|
|PLANNAME     |       The name of the plan for the program to execute dynamic queries, e.g. DSNTEPB1|
|USERNAME     |       User name of DBADM of the DATABASE. If the value is blank, the step to grant the privilege is skipped|
|DATABP   |   The name of the BUFFERPOOL to be used for data pages, e.g. BP1|
|INDEXBP |    The name of the INDEXBP to be used, e.g. BP1|
|STOGROUP|            The name of the STOGROUP to be used, e.g. SYSDEFLT|
|CONTEXTNAME       |  The name of the local trusted context|
|REMOTECONTEXTNAME|   The name of the remote trusted context|
|CLIENTIPADDRESS |    The IP address to be authenticated and added into the remote trusted context|
|ROLENAME        |    The name of the role to be granted as DBADM and to be used in the trusted contexts. If the value is blank, the step to create the role and trusted contexts is skipped |
|LTCUSERNAME    |     The system user id used in the local trusted context|
|RMTUSERNAME   |      The system user id used in the remote trusted context|
|RMTUSER |           The user id who can use the remote trusted context|
|RMTDISTID    |       The distributed identity user name to be mapped to the remote trusted context. If the value is blank, the step to create the RACF distributed map is skipped|
|RMTDISTREG |         The distributed identity registry name to be used in the RACF map|
|RACFOWNER |          The owner of the RACF group to be added|
|RACFSUPERGRP|        The name of the super RACF group|
|RACFGROUP  |         The name of the RACF group to be added. If the value is blank, the step to add RACF group and user is skipped|
|RACFUSER         |   The name of the RACF user to be connected into the group|

