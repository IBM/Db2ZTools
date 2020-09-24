# Update the sample Db2 software service template for provisioning Db2 data sharing groups for APAR PH28183

 This PTF for APAR PH28183 adds a new Db2 subsystem parameter in DSN6SPRM called UTILS_USE_ZSORT that specifies whether Db2 utilities use the IBM Integrated Accelerator for Z Sort interface when invoking DFSORT for utility processing. However, the use of the integrated sort acceleration depends on other run-time variables and hardware.

 Valid options are:
 - NO  : Db2 utilities do not use integrated sort acceleration when invoking DFSORT. This is the default setting.
 - YES : Db2 utilities attempt to use the integrated sort acceleration if possible when invoking DFSORT.

 You must update the following zFS files that you have extracted from the `Db2ProvisionSystemDS.pax` file (including any extracted zFS files that you have customized) as indicated below.


## Job `dsntijuz`

(a) Locate these two lines:

    #formatLine("               UTILS_HSM_MSGDS_HLQ=${UHMDH},",
                71,15,false,"X")

(b) Add the following two lines directly after the above lines:

    #formatLine("               UTILS_USE_ZSORT=${UZSORT},",
                71,15,false,"X")


## z/OSMF variable input file `dsntivin`

(a) Locate these two lines:

    ## -- PANEL DSNTIP7 (SQL OBJECT DEFAULTS PANEL 1) --
    ## "DSVCI" on panel DSNTIP7: VARY DS CONTROL INTERVAL

(b) Add the following 3 lines directly -before- the above lines:

    ## "UZSORT" on panel DSNTIP63: UTILS USE ZSORT
    ## The UTILS_USE_ZSORT subsystem parameter specifies whether Db2 utilities use the IBM Integrated Accelerator for Z Sort interface when invoking DFSORT for utility processing. However, the use of the integrated sort acceleration depends on other run-time variables and hardware.
    UZSORT=x

    where 'x' is
      - NO, if you are updating the original dsntivin or dsntivia file extracted from the Db2ProvisionSystemDS.pax file.
      - Desired setting for UTILS_USE_ZSORT (NO or YES), if you are updating your customized dsntivin or dsntivia file.


## z/OSMF variable input file `dsntivia`

    Follow the instructions given for z/OSMF variable input file dsntivin, above


## z/OSMF workflow definition file `dsntiwpc.xml`

(a) Locate this line:

    <variable name="VOLTDEVT" scope="instance">

(b) Add the following lines directly -before- the above line:

    <variable name="UZSORT" scope="instance">
    <label>UZSORT</label>
    <abstract>UTILS USE ZSORT</abstract>
    <description>
    The UTILS_USE_ZSORT subsystem parameter specifies whether Db2 utilities use the IBM Integrated Accelerator for Z Sort interface when invoking DFSORT for utility processing. However, the use of the integrated sort acceleration depends on other run-time variables and hardware.
    </description>
    <category>ZPARMS</category>
    <string>
    <maxLength>40</maxLength>
    </string>
    </variable>

(c) Locate this line:

    <variableValue name="VCATALOG" scope="instance" required="false" noPromptIfSet="true"></variableValue>

(d) Add the following line directly -before- the above line:

    <variableValue name="UZSORT" scope="instance" required="false" noPromptIfSet="true"></variableValue>