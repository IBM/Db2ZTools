# Update the sample Db2 software service template for provisioning Db2 data sharing groups for APAR PH25217

 This PTF for APAR PH25217 adds a new Db2 subsystem parameter in DSN6SPRM called REORG_INDEX_NOSYSUT1 that specifies whether the REORG INDEX SHRLEVEL REFERENCE or CHANGE utility should avoid using the SYSUT1 or work data set to hold the unloaded index keys. You must update the extracted zFS files from the `Db2ProvisionSystemDS.pax` file, as described below:

## Job `dsntijuz`:

(a) Locate these two lines:

    #formatLine("               REORG_LIST_PROCESSING=${RLPR},", 
            71,15,false,"X")                        

(b) Add the following two lines directly -before- the first of the above lines (a):

    #formatLine("               REORG_INDEX_NOSYSUT1=${RINSU},", 
            71,15,false,"X") 

## z/OSMF variable input files `dsntivin` and `dsntivia`: 

(a) In both files, locate these two line:

    ## "UZSORT" on panel DSNTIP63: UTILS USE ZSORT
    ## The UTILS_USE_ZSORT subsystem parameter specifies...

(b) In both files, add the following three lines directly -before- the above lines (a):

    ## "RINSU" on panel DSNTIP63: REORG INDEX NOSYSUT1
    ## The REORG_INDEX_NOSYSUT1 subsystem parameter specifies whether the REORG INDEX SHRLEVEL REFERENCE or CHANGE utility should avoid using the SYSUT1 or work data set to hold the unloaded index keys. 
    RINSU=x

    where 'x' is the desired setting for REORG_INDEX_NOSYSUT1 (NO or YES)

## z/OSMF workflow definition file `dsntiwpc.xml`:

(a) Locate this line: 

    <variable name="RLFERRD" scope="instance">                             

(b) Add the following 11 lines directly -before- the above line (a):

    <variable name="RINSU" scope="instance">
    <label>RINSU</label>
    <abstract>REORG INDEX NOSYSUT1</abstract>
    <description>
    The REORG_INDEX_NOSYSUT1 subsystem parameter specifies whether the REORG INDEX SHRLEVEL REFERENCE or CHANGE utility should avoid using the SYSUT1 or work data set to hold the unloaded index keys.
    </description>
    <category>ZPARMS</category>
    <string>
    <maxLength>40</maxLength>
    </string>
    </variable>

(c) Locate this line

    <variableValue name="RLFERRD" scope="instance" required="false" noPromptIfSet="true"></variableValue>

(d) Add this line directly -before- the above line (c):

    <variableValue name="RINSU" scope="instance" required="false" noPromptIfSet="true"></variableValue>
