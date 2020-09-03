# Update the sample Db2 software service template for provisioning Db2 data sharing groups for APAR PH27822

 This PTF for APAR PH27822 modifies the default setting of Db2 subsystem parameter DEFAULT_INSERT_ALGORITHM in DSN6SPRM that specifies the default algorithm for inserting data into table spaces. The default setting is changed from 2 to 1. You must update the extracted zFS files from the `Db2ProvisionSystemDS.pax` file, as described below:

## z/OSMF variable input files `dsntivin` and `dsntivia`: 

* Find and change the following keyword parameter value from 2 to 1:

    DEFAULT_INSERT_ALGORITHM=1

# Note
 If the current DEFAULT_INSERT_ALGORITHM setting of your provisioned Db2 subsystem is 2, see the Recommended Actions in the 2020.07.23 Red Alert:
https://www14.software.ibm.com/webapp/set2/sas/f/redAlerts/20200723.html

 If you have any questions, please contact IBM Support.
