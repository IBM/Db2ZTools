# Update the sample Db2 software service template for provisioning Db2 data sharing groups for APAR PH26317

 This PTF for APAR PH26317 removes two existing Db2 subsystem parameters, OBJECT_CREATE_FORMAT and UTILITY_OBJECT_CONVERSION from Db2-supplied z/OSMF variable input and workflow definition files.  You must update the extracted zFS files from the `Db2ProvisionSystemDS.pax` file, as described below:

## Update Job dsntijuz:

 (a) Locate and remove these 2 lines:

    #formatLine("               OBJECT_CREATE_FORMAT=${OBCF},",
                    71,15,false,"X")                                     


(b) Locate and remove these 2 lines:

    #formatLine("               UTILITY_OBJECT_CONVERSION=${UTOC},", 
                71,15,false,"X") 

## Update the z/OSMF variable input files `dsntivin` and `dsntivia`: 

(a) In both files, locate and remove the following lines for OBJECT_CREATE_FORMAT:

    ## "OBCF" on panel DSNTIP7: OBJECT CREATE FORMAT
    ## The OBJECT_CREATE_FORMAT subsystem parameter ...
    OBCF=$INSVALUE

(b) In both files, locate and remove the following lines for UTILITY_OBJECT_CONVERSION:
 
    ## "UTOC" on panel DSNTIP7: UTILITY OBJECT CONVERSION   
    ## The value of the UTILITY_OBJECT_CONVERSION parameter ...
    UTOC=$INSVALUE                                       

## Update z/OSMF workflow definition file `dsntiwpc.xml`:

(a) Locate and remove these lines: 
 
    <variable name="OBCF" scope="instance">     
    <label>OBCF</label>                         
    <abstract>OBJECT CREATE FORMAT</abstract>   
    <description>                               
    The OBJECT_CREATE_FORMAT subsystem parameter ...
    </description>                              
    <category>ZPARMS</category>                 
    <string>                                    
    <maxLength>40</maxLength>                   
    </string>                                   
    </variable>

(b) Locate and remove these lines: 

    <variable name="UTOC" scope="instance">             
    <label>UTOC</label>                                 
    <abstract>UTILITY OBJECT CONVERSION</abstract>      
    <description>                                       
    The value of the UTILITY_OBJECT_CONVERSION parameter ...
    </description>                                      
    <category>ZPARMS</category>                         
    <string>                                            
    <maxLength>40</maxLength>                           
    </string>                                           
    </variable>

(c) Locate and remove this line: 

    <variableValue name="OBCF" scope="instance" ...

(d) Locate and remove this line: 

    <variableValue name="UTOC" scope="instance" ...

