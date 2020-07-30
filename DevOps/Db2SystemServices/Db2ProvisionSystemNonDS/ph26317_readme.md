# Updating the sample Db2 software service template for provisioning stand-alone Db2 subsystems for PH26317

The PTF for PH26317 modifies job DSNTIJUZ. It also removes two existing Db2 subsystem parameters, OBJECT_CREATE_FORMAT and UTILITY_OBJECT_CONVERSION from Db2-supplied z/OSMF variable input and workflow definition files. You must update the extracted zFS files from the `Db2ProvisionSystemNonDS.pax` file, as described below:

## Update job dsntijuz:

(a) Locate and remove these 2 lines:

    #formatLine("               OBJECT_CREATE_FORMAT=${OBCF},",
                71,15,false,"X")                                     


(b) Locate and remove these 2 lines:

    #formatLine("               UTILITY_OBJECT_CONVERSION=${UTOC},", 
                71,15,false,"X") 

## Update the z/OSMF variable input file dsntivin

(a) Locate and remove the following lines for OBJECT CREATE FORMAT:

    ## "OBCF" on panel DSNTIP7: OBJECT CREATE FORMAT
    ## The OBJECT_CREATE_FORMAT subsystem parameter ...
    OBCF=$INSVALUE                                  

(b) Locate and remove the following lines for UTILITY_OBJECT_CONVERSION: 

    ## "UTOC" on panel DSNTIP7: UTILITY OBJECT CONVERSION   
    ## The value of the UTILITY_OBJECT_CONVERSION parameter ...
    UTOC=$INSVALUE                              

## Update the z/OSMF workflow definition file dsntiwin.xml:

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
 

