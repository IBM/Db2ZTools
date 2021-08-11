# Updating the sample Db2 software service template for provisioning stand-alone Db2 subsystems for PH25217

 This PTF for APAR PI75518 adds two new Db2 subsystem parameter in DSN6SPRM called REORG_IC_LIMIT_DASD and REORG_IC_LIMIT_TAPE that specify respectively the maximum number of sequential DASD and TAPE image copies that the REORG TABLESPACE utility can allocate. You must update the extracted zFS files from the `Db2ProvisionSystemNonDS.pax` file, as described below:

## Job `dsntijuz`:

(a) Locate these two lines:

    #formatLine("               REORG_INDEX_NOSYSUT1=${RINSU},",
            71,15,false,"X")                        

(b) Add the following four lines directly -before- the first of the above lines (a): 

    #formatLine("               REORG_IC_LIMIT_DASD=${RICLD},", 
            71,15,false,"X")                                
    #formatLine("               REORG_IC_LIMIT_TAPE=${RICLT},", 
            71,15,false,"X")                                                                                    

## z/OSMF variable input file `dsntivin`

(a) Locate these two lines:

    ## "RINSU" on panel DSNTIP63: REORG INDEX NOSYSUT1
    ## The REORG_INDEX_NOSYSUT1 subsystem parameter specifies...     

(b) Add the following six lines directly -before- the above lines (a):

    ## "RICLD" on panel DSNTIP63: REORG IC LIMIT DASD
    ## The REORG_IC_LIMIT_DASD subsystem parameter specifies the maximum number of sequential DASD image copies that the REORG TABLESPACE utility can allocate.
    RICLD=x
    ## "RICLT" on panel DSNTIP63: REORG IC LIMIT TAPE
    ## The REORG_IC_LIMIT_TAPE subsystem parameter specifies the maximum number of sequential TAPE image copies that the REORG TABLESPACE utility can allocate.
    RICLT=y                     

    where 'x' is the desired setting for REORG_IC_LIMIT_DASD (an integer from 0 - 32767)
          'y' is the desired setting for REORG_IC_LIMIT_TAPE (an integer from 0 - 32767)

## z/OSMF workflow definition file `dsntiwin.xml`:

(a) Locate this line:

    <variable name="RINSU" scope="instance">

(b) Add the following 22 lines directly -before- the above line (a):

    <variable name="RICLD" scope="instance">
    <label>RICLD</label>
    <abstract>REORG IC LIMIT DASD</abstract>
    <description>
    The REORG_IC_LIMIT_DASD subsystem parameter specifies the maximum number of sequential DASD image copies that the REORG TABLESPACE utility can allocate.
    </description>
    <category>ZPARMS</category>
    <string>
    <maxLength>40</maxLength>
    </string>
    </variable>
    <variable name="RICLT" scope="instance">
    <label>RICLT</label>
    <abstract>REORG IC LIMIT TAPE</abstract>
    <description>
    The REORG_IC_LIMIT_TAPE subsystem parameter specifies the maximum number of sequential TAPE image copies that the REORG TABLESPACE utility can allocate.
    </description>
    <category>ZPARMS</category>
    <string>
    <maxLength>40</maxLength>
    </string>
    </variable>

(c) Locate this line:

    <variableValue name="RINSU" scope="instance" required="false" noPromptIfSet="true"></variableValue>

(d) Add these two line directly -before- the above line (c):

    <variableValue name="RICLD" scope="instance" required="false" noPromptIfSet="true"></variableValue>
    <variableValue name="RICLT" scope="instance" required="false" noPromptIfSet="true"></variableValue>
