# REST services for Db2 instances in IBM z/OS Cloud Broker for IBM Cloud Private 
This repository contains deliverables for installing prerequisite services for Db2 instances deployed on  IBM z/OS Cloud Broker for IBM Cloud Private. The services enable the display of Db2 database objects on Db2 Service Instance Dashboard.

## Installing the services
1. Upload the SQL files as data sets or files on the z/OS system.
2. Upload the JCL files to z/VM or the z/OS system.
3. Replace symbolics in the JCL files.
4. Run the `icprest.jcl` job to create the Db2 native REST services.
5. Run the `icpgrant.jcl` job to grant execution privileges on the Db2 native REST packages.

## Files
|File name|Description|
|--|--|
|`icprest.jcl`|Builds Db2 native REST packages for IBM z/OS Cloud Broker for IBM Cloud Private, by issuing `BIND SERVICE` DSN commands.|
|`icpgrant.jcl`|Grants execution privileges on the Db2 native REST packages, by issuing `GRANT` SQL statements.|
|`icp-dbname.sql`|Queries database objects by database name.|
|`icp-schemaname.sql`|Queries database objects by schema name.|
