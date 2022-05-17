# Updating the sample Db2 software service template for provisioning stand-alone Db2 subsystems for PH36908

 This PTF for APAR PH36908 adds a new Db2 subsystem parameter in DSN6SPRM called LOAD_DEL_IMPLICIT_SCALE that specifies how LOAD FORMAT DELIMITED determines decimal data scale when a decimal point is not specified. You must update the extracted zFS files from the `Db2ProvisionSystemNonDS.pax` file, as described below:

## Job `dsntijuz`:

(a) Locate these two lines:

    #formatLine("               LOAD_RO_OBJECTS=${LIRO},", 
            71,15,false,"X")                        

(b) Add the following two lines directly -before- the first of the above lines (a):

    #formatLine("               LOAD_DEL_IMPLICIT_SCALE=${LDISCALE},",
            71,15,false,"X")                                                     

## z/OSMF variable input file `dsntivin`

(a) Locate these two lines:

    ## -- PANEL DSNTIP7 (SQL OBJECT DEFAULTS PANEL 1) --
    ## "DSVCI" on panel DSNTIP7: VARY DS CONTROL INTERVAL    

(b) Add the following three lines directly -before- the above lines (a):

    ## "LDISCALE" on panel DSNTIP63: LOAD FORMAT DELIMITED IMPLICIT DEC SCALE
    ## The LOAD_DEL_IMPLICIT_SCALE subsystem parameter specifies how LOAD FORMAT DELIMITED determines decimal data scale when a decimal point is not specified.
    LDISCALE=x                      

    where 'x' is the desired setting for LOAD_DEL_IMPLICIT_SCALE (NO or YES)

## z/OSMF workflow definition file `dsntiwin.xml`:

(a) Locate this line:

    <variable name="LIRO" scope="instance">                                

(b) Add the following 11 lines directly -before- the above line (a):

    <variable name="LDISCALE" scope="instance">
    <label>LDISCALE</label>
    <abstract>LOAD FORMAT DELIMITED IMPLICIT DEC SCALE</abstract>
    <description>
    The LOAD_DEL_IMPLICIT_SCALE subsystem parameter specifies how LOAD FORMAT DELIMITED determines decimal data scale when a decimal point is not specified.
    </description>
    <category>ZPARMS</category>
    <string>
    <maxLength>40</maxLength>
    </string>
    </variable>

(c) Locate this line:

    <variableValue name="LIRO" scope="instance" required="false" noPromptIfSet="true"></variableValue>

(d) Add this line directly -before- the above line (c):

    <variableValue name="LDISCALE" scope="instance" required="false" noPromptIfSet="true"></variableValue>
