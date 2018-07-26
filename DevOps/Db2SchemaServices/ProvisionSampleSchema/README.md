# Readme file for Db2 for z/OS "Create Sample Schema" as a Service

The service allows you to rapidly provision a logical collection of database
objects in an existing DB2 subsystem. These objects include 3 databases  under
the same schema. The workflow needs to be run as a template, in addition, the
instance name prefix of the software services requires an asterisk to be at the
end so that z/OS Management Facility can generate the unique database names for
an instance.

This readme contains the following sections:
* **Prerequisites**
* **Setting up the service**
* **`provision.xml`**
* **`deprovision.xml`**
* **`deprovision.xml`**

## Prerequisites:
1.  A DB2 subsystem has been established on the system where the provision will
take place
2.  The workflow files have been copied from the factory location and the
clouddb2.input file customized for use in the local environment
3.  The following privileges have been granted to the user specified by SQLID: 
CREATEDBA privilege or SYSADM authority or System DBADM authority
4.  If you are using RACF security for DB2 and using the default
`CREATERACF.jcl` to create RACF group and user, RACF profile BATCH needs to be
defined on the subsystem where the provision will take place. If you are not
using `<mvsname>`.BATCH, you will have to modify the `CREATERACF.jcl` to reflect the
 RACF BATCH profile that is defined in the environment
5.  Bufferpool used in the CREATEDB.jcl has been activated

## Setting up the service:
The files of the service are stored in a directory in z/OS UNIX System Services (USS), and the directory including files must be accessible to z/OSMF. All the required files are packed into the pax file.

   - Download the pax file
   - Use FTP to upload the pax file in binary mode to a directory where you want to store the service in USS
   - Extract the contents of the pax file in the directory where you put the pax file
      - pax -rvf `<the name of the pax file>`

Extracting produces the following direcotry structure:
```
    <service base direcotry>    -- all files of the service
        provision.xml           -- Workflow to provision sample schema
        deprovision.xml         -- Workflow to deprovision sample schema
        actions.xml             -- Actions of the service
        clouddb2.input          -- Sample input variable file to be customized
        CREATDB.jcl             -- JCL template to create sample schema
        CREATERACF.jcl          -- JCL template to permit user access to sample schema
        CREATETC.jcl            -- JCL template to create trusted context
        CREATETCMAP.jcl         -- JCL template to associate the distributed username with a RACF user ID
        DELETERACF.jcl          -- JCL template to delete user access
        DELETETC.jcl            -- JCL template to drop trusted context
        DELETETCMAP.jcl         -- JCL template to delete distributed identify filter
        DROPDB.jcl              -- JCL template to drop sample schema
        GRANTU.jcl              -- JCL template to grant user access to sample schema
        REVOKEU.jcl             -- JCL template to revoke user access
        LOADDATA.jcl            -- JCL template to load data into sample schema
```

## `provision.xml`
This is the workflow that provisions a logical collection of database
objects under a schema in an existing DB2 subsystem. The workflow
consists of 6 steps. The first step is to dynamically provision the
database name for the databases to be created in the following steps.
The second step is to create the logical collection of database objects
in an existing DB2 subsystem. The third step is to add a RACF group and
a user, to grant DBADM to the group and to give permission of running
BATCH job, assuming the profile BATCH is defined ahead, on the
subsystem. The fourth step is to create a role with DBADM authority of
the databases created in the first step, then to create a local and a
remote trusted context with the role. This should be run once and shared
among the different instances. The fifth step is to create a RACF map to
map a distributed identity to the trusted context. The sixth step is to
assign DBADM privilege of these objects to a user that the database
objects are provisioned for. The third, fourth, fifth and sixth step are
optional based on the need, refer to the description of input variable
file section on how to skip a certain step in the workflow. The seventh
step is to load the data into the tables.
Customize the security JCLs
based on your security solution, policy and profiles before running the
workflow.
 
The following table lists the steps and any associated JCL file:

|Step|    Description                                       |  JCL           |  Optional|
|--- |---                                                   |---             |---       |
|1   | N/A(REST CALL) | NO     | Provision database name dynamically |
|2   | CREATEDB       | NO     | Create a logical collection of database objects under a schema |
|3   | CREATERACF     | YES   |  Create a RACF group and user with DBADM authority of the objects |
|4   | CREATETC |      YES    | Create a local and remote trusted context granting a role with DBADM authority |
|5   | CREATETCMAP    | YES    | Create a RACF map to the trusted context |
|6   | GRANTU         | YES    | Grant DBADM authority of these objects to a user |
|7   | LOADDATA       | NO     | Load data into these objects |
 
## `deprovision.xml`
This is the workflow that deprovisions a logical collection of database
objects under a schema from an existing DB2 subsystem. The workflow
consists of 5 steps. The first step is to revoke the DBADM privilege
from the user that the database objects are provisioned for. The second
step is to delete the provisioned RACF map. The third step is to delete
the provisioned trusted contexts and role. The fourth step is to delete
the provisioned RACF group and user. The first, second, third and fourth
steps are optional based on the need, refer to the description of input
variable file section on how to skip a certain step in the workflow. The
fifth step is to drop the objects.
 
 
The following table lists the steps and any associated JCL file:

|Step|    Description                                       |  JCL           |  Optional|
|--- |---                                                   |---             |---       |
|1|   Revoke DBADM authority from a user      |REVOKEU |    YES
|2|   Delete RACF map of the trusted context | DELETETCMAP | YES
|3|   Delete trusted contexts and role |       DELETETC   | YES
|4|   Delete a RACF group and user  |          DELETERACF | YES
|5|   Drop the database objects  |             DROPDB     | NO|


The `clouddb2.input` file contains the following properties:

|Property    |Remarks|
|---         |---    |
|DSNLOAD      |       The name of the main APF-authorized DB2 load module library that is to be used by installation and sample jobs|
|DSNEXIT      |       The name of the library where your DSNZPxxx module, application defaults load module (dsnhdecp), and exit routines are to be placed|
|DSNSAMP      |       The name of the DB2 sample library in which the sample data used by the LOADDATA job is stored|
|DSNIVPD      |       The name of the DB2 installation verification process job library in which the sample data used by the LOADDATA job is stored|
|MVSSNAME     |       The z/OS subsystem name for DB2, where the database will be provisioned and deprovisioned|
|RUNLIB       |       The name of the DB2 sample application load module library, where program to execute dynamic queries can be found|
|PROGNAME      |      The name of the program to execute dynamic queries, e.g. DSNTEP2|
|PLANNAME     |       The name of the plan for the program to execute dynamic queries, e.g. DSNTEPB1|
|SORTLIB      |       The sort library used by the DB2 LOAD job|
|TSPREFIX     |       The prefix of the sample table spaces to be created|
|USERNAME     |       User name of DBADM of the DATABASE. If the value is blank, the step to grant the privilege is skipped|
|SQLID        |       The ID used to execute the DDL to create the sample databases|
|DBASEA      |        The name of the sample databases to be created. The name is provisioned dynamically|
|DBASEP     |         The name of the sample databases to be created. The name is provisioned dynamically|
|DBASEX    |          The name of the sample databases to be created. The name is provisioned dynamically|
|BP       |           The name of the BUFFERPOOL and INDEXBP to be used, e.g. BP1|
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
