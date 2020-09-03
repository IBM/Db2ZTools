# Update the sample Db2 software service template for provisioning Db2 data sharing groups for APAR PH26131

 This PTF for APAR PH26131 adds a new Db2 subsystem parameter in DSN6SPRM called LOAD_RO_OBJECTS that specifies whether Db2 utilities allow LOAD on all SHRLEVELs including the data loading and inserting cases to load into read-only (RO) objects. You must update the extracted zFS files from the `Db2ProvisionSystemDS.pax` file, as described below:

## Job `dsntijuz`:

(a) Locate these two lines:

    #formatLine("               LRDRTHLD=${LRDRTHLD},", 
                71,15,false,"X")

(b) Add the following two lines directly -before- the first of the above lines (a):

    #formatLine("               LOAD_RO_OBJECTS=${LIRO},", 
                71,15,false,"X") 

## z/OSMF variable input files `dsntivin` and `dsntivia`: 

(a) In both files, locate these two line:

    ## -- PANEL DSNTIP61 (DB2 UTILITIES PARAMETERS PANEL 2) --
    ## "RECFASRP" on panel DSNTIP61: FAST RESTORE 

(b) In both files, add the following three lines directly -before- the above lines (a):

    ## "LIRO" on panel DSNTIP6: LOAD RO OBJECTS
    ## The LOAD_RO_OBJECTS subsystem parameter specifies whether Db2 utilities allow LOAD on all SHRLEVELs including the data loading and inserting cases to load into read-only (RO) objects.
    LIRO=x

    where 'x' is the desired setting for LOAD_RO_OBJECTS (NO or YES)

## z/OSMF workflow definition file `dsntiwpc.xml`:

(a) Locate this line: 

    <variable name="LOBINLEN" scope="instance">

(b) Add the following 11 lines directly -before- the above line (a):

    <variable name="LIRO" scope="instance">
    <label>LIRO</label>
    <abstract>LOAD RO OBJECTS</abstract>
    <description>
    The LOAD_RO_OBJECTS subsystem parameter specifies whether Db2 utilities allow LOAD on all SHRLEVELs including the data loading and inserting cases to load into read-only (RO) objects.
    </description>
    <category>ZPARMS</category>
    <string>
    <maxLength>40</maxLength>
    </string>
    </variable>

(c) Locate this line:

    <variableValue name="LOBINLEN" scope="instance" required="false" noPromptIfSet="true"></variableValue>

(d) Add this line directly -before- the above line (c):

    <variableValue name="LIRO" scope="instance" required="false" noPromptIfSet="true"></variableValue>

