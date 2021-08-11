# Update the sample Db2 software service template for provisioning Db2 data sharing groups for APAR PH30978

 This PTF for APAR PH30978 adds a new Db2 subsystem parameter in DSN6SPRM called  FTB_NON_UNIQUE_INDEX that specifies whether fast index traversal for non-unique indexes is enabled. You must update the extracted zFS files from the `Db2ProvisionSystemDS.pax` file, as described below:

## Job `dsntijuz`:

(a) Locate these two lines:

    #formatLine("               FLASHCOPY_XRCP=${FCXC},", 
            71,15,false,"X")                        

(b) Add the following two lines directly -after- the first of the above lines (a):

    #formatLine("               FTB_NON_UNIQUE_INDEX=${FTBUO},", 
            71,15,false,"X") 

## z/OSMF variable input files `dsntivin` and `dsntivia`: 

(a) In both files, locate these two line:

    ## "DDLM" on panel DSNTIP71: DDL MATERIALIZATION
    ## Corresponds to the DDL_MATERIALIZATION subsystem parameter...

(b) In both files, add the following three lines directly -before- the above lines (a):

    ## "FTBUO" on panel DSNTIP71: FTB NON UNIQUE INDEX
    ## The FTB_NON_UNIQUE_INDEX subsystem parameter specifies whether fast index traversal for non-unique indexes is enabled.
    FTBUO=x

    where 'x' is the desired setting for FTB_NON_UNIQUE_INDEX (NO or YES)

## z/OSMF workflow definition file `dsntiwpc.xml`:

(a) Locate this line:

    <variable name="GRPNAME" scope="instance">                             

(b) Add the following 11 lines directly -before- the above line (a):

    <variable name="FTBUO" scope="instance">
    <label>FTBUO</label>
    <abstract>FTB NON UNIQUE INDEX</abstract>
    <description>
    The FTB_NON_UNIQUE_INDEX subsystem parameter specifies whether fast index traversal for non-unique indexes is enabled.
    </description>
    <category>ZPARMS</category>
    <string>
    <maxLength>40</maxLength>
    </string>
    </variable>

(c) Locate this line:

    <variableValue name="FCXC" scope="instance" required="false" noPromptIfSet="true"></variableValue>

(d) Add this line directly -after- the above line (c):

    <variableValue name="FTBUO" scope="instance" required="false" noPromptIfSet="true"></variableValue>
