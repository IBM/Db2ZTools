# Update the sample Db2 software service template for provisioning Db2 data sharing groups for APAR PH24358

The PTF for APAR PH24358 removes two existing Db2 subsystem parameters, COMPRESS_SPT01 and SPT01_INLINE_LENGTH from Db2-supplied z/OSMF variable input and workflow definition files. You must update the extracted zFS files from the `Db2ProvisionSystemDS.pax` file as described below:

## Update job dsntijuz:

(a) Locate and remove these 2 lines:

    #formatLine("               COMPRESS_SPT01=${CMPSPT01},",
                71,15,false,"X")      

(b) Locate and remove these 2 lines:

    #formatLine("               SPT01_INLINE_LENGTH=${SPT01INL},",  
                71,15,false,"X") 


## Update z/OSMF variable input files dsntivin and dsntivia: 

(a) In both files, locate and remove the following lines for COMPRESS_SPT01:

    ## "CMPSPT01" on panel DSNTIPA2: COMPRESS SPT01
    ## The value of the COMPRESS_SPT01 subsystem parameter ...
    CMPSPT01=$INSVALUE

(b) In both files, locate and remove the following lines for SPT01_INLINE_LENGTH:
 
    ## "SPT01INL" on panel DSNTIPA2: SPT01 INLINE LENGTH     
    ## The SPT01_INLINE_LENGTH subsystem parameter specifies ... 
    SPT01INL=$INSVALUE                                       
 

## Update the z/OSMF workflow definition file dsntiwpc.xml:

(a) To update the abstract for variable name CDRL: locate this line

    <label>CDRL</label>

...and change the next line from:

    <abstract>COMPRESS SPT01</abstract>

...to:
    <abstract>COMPRESS DB2 DIR LOBS</abstract>
        
(b) Locate and remove these lines: 
 
    <variable name="CMPSPT01" scope="instance">
    <label>CMPSPT01</label>
    <abstract>COMPRESS SPT01</abstract>
    <description>
    The value of the COMPRESS_SPT01 subsystem parameter ...
    </description>
    <category>Storage</category>
    <string>
    <maxLength>40</maxLength>
    </string>
    </variable>

(c) Locate and remove these lines: 

    <variable name="SPT01INL" scope="instance">
    <label>SPT01INL</label>
    <abstract>SPT01 INLINE LENGTH</abstract>
    <description>
    The SPT01_INLINE_LENGTH subsystem parameter specifies ...
    </description>
    <category>Storage</category>
    <string>
    <maxLength>40</maxLength>
    </string>
    </variable>
    
(d) Locate and remove this line: 

    <variableValue name="CMPSPT01" scope="instance" ...

(e) Locate and remove this line: 

    <variableValue name="SPT01INL" scope="instance" ...
