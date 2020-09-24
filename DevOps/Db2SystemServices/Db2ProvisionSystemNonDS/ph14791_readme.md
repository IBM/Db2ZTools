# Updating the sample Db2 software service template for provisioning stand-alone Db2 subsystems for PH14791

 This PTF for APAR PH14791 adds a new Db2 subsystem parameter in DSN6SPRM called ALLOW_UPD_DEL_INS_WITH_UR that specifies whether Db2 allows UPDATE, DELETE, or INSERT statements to be prepared with the isolation-clause attribute WITH UR. You must update the extracted zFS files from the `Db2ProvisionSystemNonDS.pax` file, as described below:

## Job `dsntijuz`:

(a) Locate these two lines:

    #formatLine("               ALTERNATE_CP=${BSACP},",
                71,15,false,"X")

(b) Add the following two lines directly -before- the first of the above lines (a):

    #formatLine("               ALLOW_UPD_DEL_INS_WITH_UR=${AUDIWU},",
                71,15,false,"X")

## z/OSMF variable input file `dsntivin`:

(a) Locate this lines:

    ## "OFFLOAD" on panel DSNTIPM4: OFFLOAD

(b) Add the following three lines directly -before- the above line (a):

    ## "AUDIWU" on panel DSNTIPM4: ALLOW_UPD_DEL_INS_WITH_UR
    ## Specifies whether Db2 allows UPDATE, DELETE, or INSERT statements to be prepared with the isolation-clause attribute WITH UR.
    AUDIWU=x

    where 'x' is the desired setting for ALLOW_UPD_DEL_INS_WITH_UR (NO or YES)

## z/OSMF workflow definition file `dsntiwin.xml`:

(a) Locate this line: 

    <variable name="AUTCMPAT" scope="instance">

(b) Add the following 11 lines directly -before- the above line (a):

    <variable name="AUDIWU" scope="instance">
    <label>AUDIWU</label>
    <abstract>ALLOW_UPD_DEL_INS_WITH_UR</abstract>
    <description>
    Specifies whether Db2 allows UPDATE, DELETE, or INSERT statements to be prepared with the isolation-clause attribute WITH UR.
    </description>
    <category>ZPARMS</category>
    <string>
    <maxLength>40</maxLength>
    </string>
    </variable>

(c) Locate this line:

    <variableValue name="AUTHCACH" scope="instance" required="false" noPromptIfSet="true"><variableValue>

(d) Add this line directly -before- the above line (c):

    <variableValue name="AUDIWU" scope="instance" required="false" noPromptIfSet="true"><variableValue>
 

