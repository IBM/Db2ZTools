# Update the sample Db2 software service template for provisioning Db2 data sharing groups for APAR PH28280

This PTF for APAR PH28280 removes eight existing Db2 subsystem parameters, CACHEPAC, CACHERAC, IRLMAUT, IRLMSWT, CHGDC, EDPROP, PCLOSEN, and MGEXTSZ from Db2-supplied z/OSMF variable input and workflow definition files. You must update the following zFS files that you have extracted from the  `Db2ProvisionSystemDS.pax` file (including any extracted zFS files that you have customized) as described below:

## Job `dsntijuz`:

(a) Locate and remove these 2 lines:

    #formatLine("               CACHEPAC=${CACHEPAC},",
                71,15,false,"X")                                           

(b) Locate and remove these 2 lines:

    #formatLine("               CACHERAC=${CACHERAC},",
                71,15,false,"X") 

(c) Locate and remove these 2 lines:

    #formatLine("               CHGDC=${CHGDC},",
                71,15,false,"X")                                           

(d) Locate and remove these 2 lines:

    #formatLine("               EDPROP=${EDPROP},",  
                71,15,false,"X")

(e) Locate and remove these 2 lines:

    #formatLine("               IRLMAUT=${IRLMAUTO},",
                71,15,false,"X")                                           

(f) Locate and remove these 2 lines:

    #formatLine("               IRLMSWT=${IRLMSTTO},",
                71,15,false,"X")

(g) Locate and remove these 2 lines:

    #formatLine("               MGEXTSZ=${MGEXTSZ},", 
                71,15,false,"X")

(h) Locate and remove these 2 lines:

    #formatLine("               PCLOSEN=${PCLOSEN},",
                71,15,false,"X")

## z/OSMF variable input files `dsntivin` and `dsntivia`: 

(a) In both files, locate and remove the following lines for IRLMAUT:

    ## "IRLMAUTO" on panel DSNTIPI: AUTO START 
    ## The IRLMAUT subsystem parameter defines ...
    IRLMAUTO=x

    where 'x' is
     - YES, if you are updating the original dsntivin or dsntivia file extracted from the pax file.
     - Current subsystem parameter setting, if you are updating your customized dsntivin or dsntivia file.

(b) In both files, locate and remove the following lines for IRLMSWT: 

    ## "IRLMSTTO" on panel DSNTIPI: TIME TO AUTOSTART
    ## The IRLMSWT subsystem parameter specifies the IRLM ...
    IRLMSTTO=x

    where 'x' is
     - 120, if you are updating the original dsntivin or dsntivia file extracted from the pax file.
     - Current subsystem parameter setting, if you are updating your customized dsntivin or dsntivia file.


(c) In both files, locate and remove the following lines for PCLOSEN:

    ## "PCLOSEN" on panel DSNTIPL1: RO SWITCH CHKPTS 
    ## The PCLOSEN subsystem parameter specifies ...
    PCLOSEN=x

    where 'x' is
     - 15, if you are updating the original dsntivin or dsntivia file extracted from the pax file.
     - Current subsystem parameter setting, if you are updating your customized dsntivin or dsntivia file.

(d) In both files, locate and remove the following lines for CHGDC:

    ## "CHGDC" on panel DSNTIPO: DPROP SUPPORT        
    ## The value of the DPROP SUPPORT field determines ...
    CHGDC=x

    where 'x' is
     - NO, if you are updating the original dsntivin or dsntivia file extracted from the pax file.
     - Current subsystem parameter setting, if you are updating your customized dsntivin or dsntivia file.

(e) In both files, locate and remove the following lines for EDPROP: 

    ## "EDPROP" on panel DSNTIPO: DPROP SUPPORT       
    ## The value of the DPROP SUPPORT field determines ...
    EDPROP=x

    where 'x' is
     - NO, if you are updating the original dsntivin or dsntivia file extracted from the pax file.
     - Current subsystem parameter setting, if you are updating your customized dsntivin or dsntivia file.

(f) In both files, locate and remove the following lines for CACHEPAC:

    ## "CACHEPAC" on panel DSNTIPP: PACKAGE AUTH CACHE
    ## The CACHEPAC subsystem parameter determines ...
    CACHEPAC=x

    where 'x' is
     - 5242880, if you are updating the original dsntivin or dsntivia file extracted from the pax file.
     - Current subsystem parameter setting, if you are updating your customized dsntivin or dsntivia file.

(g) In both files, locate and remove the following lines for CACHERAC: 

    ## "CACHERAC" on panel DSNTIPP: ROUTINE AUTH CACHE 
    ## The CACHERAC subsystem parameter determines ...
    CACHERAC=x

    where 'x' is
     - 5242880, if you are updating the original dsntivin or dsntivia file extracted from the pax file.
     - Current subsystem parameter setting, if you are updating your customized dsntivin or dsntivia file.

(h) In both files, locate and remove the following lines for MGEXTSZ: 

    ## "MGEXTSZ" on panel DSNTIP7: OPTIMIZE EXTENT SIZING
    ## The MGEXTSZ subsystem parameter controls whether ...
    MGEXTSZ=x

    where 'x' is
     - YES, if you are updating the original dsntivin or dsntivia file extracted from the pax file.
     - Current subsystem parameter setting, if you are updating your customized dsntivin or dsntivia file.                                     

## z/OSMF workflow definition file `dsntiwpc.xml`:

(a) Locate and remove these lines: 

    <variable name="IRLMAUTO" scope="instance">
    <label>IRLMAUTO</label>                    
    <abstract>AUTO START</abstract>            
    <description>                              
    The IRLMAUT subsystem parameter defines ...
    </description>                             
    <category>IRLM</category>                  
    <string>                                  
    <maxLength>40</maxLength>                 
    </string>                                 
    </variable>                                

(b) Locate and remove these lines: 

    <variable name="IRLMSTTO" scope="instance">
    <label>IRLMSTTO</label>                    
    <abstract>TIME TO AUTOSTART</abstract>     
    <description>                              
    The IRLMSWT subsystem parameter specifies ...
    </description>                             
    <category>IRLM</category>                  
    <string>                                   
    <maxLength>40</maxLength>                  
    </string>                                  
    </variable>                              

(c) Locate and remove these lines: 

    <variable name="CACHEPAC" scope="instance"> 
    <label>CACHEPAC</label>                         
    <abstract>PACKAGE AUTH CACHE</abstract> 
    <description>                                   
    The CACHEPAC subsystem parameter determines ...
    </description>                                  
    <category>ZPARMS</category>                   
    <string>                                      
    <maxLength>40</maxLength>                     
    </string>                                       
    </variable>                                    

(d) Locate and remove these lines: 

    <variable name="CACHERAC" scope="instance"> 
    <label>CACHERAC</label>                     
    <abstract>ROUTINE AUTH CACHE</abstract>     
    <description>                               
    The CACHERAC subsystem parameter determines ...
    </description>                              
    <category>ZPARMS</category>                 
    <string>                                    
    <maxLength>40</maxLength>                   
    </string>                                   
    </variable>                                 

(e) Locate and remove these lines: 

    <variable name="CHGDC" scope="instance">
    <label>CHGDC</label>                    
    <abstract>DPROP SUPPORT</abstract>      
    <description>                           
    The value of the DPROP SUPPORT field determines ...
    </description>                          
    <category>ZPARMS</category>             
    <string>                                
    <maxLength>40</maxLength>               
    </string>                               
    </variable>                             

(f) Locate and remove these lines: 

    <variable name="EDPROP" scope="instance">      
    <label>EDPROP</label>                          
    <abstract>DPROP SUPPORT</abstract>             
    <description>                                  
    The value of the DPROP SUPPORT field determines ...
    </description>                                 
    <category>ZPARMS</category>                    
    <string>                                       
    <maxLength>40</maxLength>                      
    </string>                                      
    </variable>                                    

(g) Locate and remove these lines: 

    <variable name="MGEXTSZ" scope="instance">      
    <label>MGEXTSZ</label>                          
    <abstract>OPTIMIZE EXTENT SIZING</abstract>     
    <description>                                   
    The MGEXTSZ subsystem parameter controls ...
    </description>                                  
    <category>ZPARMS</category>                     
    <string>                                        
    <maxLength>40</maxLength>                       
    </string>                                       
    </variable>                                     

(h) Locate and remove these lines: 

    <variable name="PCLOSEN" scope="instance">
    <label>PCLOSEN</label>                    
    <abstract>RO SWITCH CHKPTS</abstract>     
    <description>                             
    The PCLOSEN subsystem parameter specifies ...
    </description>                            
    <category>ZPARMS</category>               
    <string>                                  
    <maxLength>40</maxLength>                 
    </string>                                 
    </variable> 

(i) Locate and remove this line: 

    <variableValue name="CACHEPAC" scope="instance" ...

(j) Locate and remove this line: 

    <variableValue name="CACHERAC" scope="instance" ...

(k) Locate and remove this line: 

    <variableValue name="CHGDC" scope="instance" ...
    
(l) Locate and remove this line: 

    <variableValue name="EDPROP" scope="instance" ...

(m) Locate and remove this line: 

    <variableValue name="IRLMAUTO" scope="instance" ...

(n) Locate and remove this line: 

    <variableValue name="IRLMSTTO" scope="instance" ...

(o) Locate and remove this line: 

    <variableValue name="MGEXTSZ" scope="instance" ...

(p) Locate and remove this line: 

    <variableValue name="PCLOSEN" scope="instance" ...