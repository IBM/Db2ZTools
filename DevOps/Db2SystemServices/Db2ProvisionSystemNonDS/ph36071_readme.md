# Updating the sample Db2 software service template for provisioning stand-alone Db2 subsystems for PH36071

 This PTF for APAR PH36071 adds a new Db2 subsystem parameter in DSN6SPRM called SUBSTR_COMPATIBILITY that specifies whether the Db2 SUBSTR built-in function always returns an error for invalid input. You must update the extracted zFS files from the `Db2ProvisionSystemNonDS.pax` file, as described below:

## Job `dsntijuz`:

(a) Locate these two lines:

    #formatLine("               SUPERRS=${SUPERRS},", 
            71,15,false,"X")                        

(b) Add the following two lines directly -before- the first of the above lines (a):

    #formatLine("               SUBSTR_COMPATIBILITY=${SUBSTRCP},",
            71,15,false,"X")                                                     

## z/OSMF variable input file `dsntivin`

(a) Locate these two lines:

    ## -- PANEL DSNTIPZ (DATA DEFINITION CONTROL SUPPORT) --
    ## "RGFINSTL" on panel DSNTIPZ: INSTALL DD CONTROL SUPT     

(b) Add the following three lines directly -before- the above lines (a):

    ## "SUBSTRCP" on panel DSNTIPX: SUBSTR COMPATIBILITY
    ## The SUBSTR_COMPATIBILITY subsystem parameter specifies whether the Db2 SUBSTR built-in function always returns an error for invalid input.
    SUBSTRCP=x                      

    where 'x' is the desired setting for SUBSTR_COMPATIBILITY (PREVIOUS or CURRENT)

## z/OSMF workflow definition file `dsntiwin.xml`:

(a) Locate this line:

    <variable name="SUPERRS" scope="instance">                                

(b) Add the following 11 lines directly -before- the above line (a):

    <variable name="SUBSTRCP" scope="instance">
    <label>SUBSTRCP</label>
    <abstract>SUBSTR COMPATIBILITY</abstract>
    <description>
    The SUBSTR_COMPATIBILITY subsystem parameter specifies whether the Db2 SUBSTR built-in function always returns an error for invalid input.
    </description>
    <category>ZPARMS</category>
    <string>
    <maxLength>40</maxLength>
    </string>
    </variable>

(c) Locate this line:

    <variableValue name="SUPERRS" scope="instance" required="false" noPromptIfSet="true"></variableValue>

(d) Add this line directly -before- the above line (c):

    <variableValue name="SUBSTRCP" scope="instance" required="false" noPromptIfSet="true"></variableValue>
