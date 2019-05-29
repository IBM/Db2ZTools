//*********************************************************************         
//*                                                                             
//* Licensed Materials - Property of IBM                                        
//* 5650-DB2                                                                    
//* (C) COPYRIGHT 2019 IBM Corp.  All Rights Reserved.                          
//*                                                                             
//* FUNCTION = CREATE DB2 NATIVE REST SERVICES FOR                              
//*            ICP Z/OS CLOUD BROKER.                                           
//*                                                                             
//* NOTES =                                                                     
//*    PRIOR TO RUNNING THIS JOB, customize it for your system:                 
//*    (1) Add a valid job card.                                                
//*    (2) Change all occurrences of the following strings:                     
//*        (A) Change the subsystem name '!DSN!' to the SSID of your            
//*            Db2.                                                             
//*        (B) Change 'DSN!!0' to the prefix of the target library              
//*            for Db2.                                                         
//*        (C) Change the owner '!AUTHID!' to the authorization ID              
//*            that owns the Db2 REST service package.                          
//*        (D) Change '!PATHDBNAM!' to the data set or file that                
//*            contains the single SQL statement to get all objects             
//*            by database name.                                                
//*        (E) Change '!PATHSCHEM!' to the data set or file that                
//*            contains the single SQL statement to get all objects             
//*            by schema name.                                                  
//*                                                                             
//*********************************************************************         
//JOBLIB  DD  DISP=SHR,                                                         
//            DSN=DSN!!0.SDSNLOAD                                               
//*********************************************************************         
//* Define data sets or files containing SQL statements                         
//*********************************************************************         
//STEP1    EXEC PGM=IKJEFT01,DYNAMNBR=20,COND=(4,LT)                            
//SQLDBNAM DD  PATH='!PATHDBNAM!',                                              
//             PATHOPTS=ORDONLY,                                                
//             RECFM=VB,LRECL=32756,BLKSIZE=32760                               
//SQLSCHEM DD  PATH='!PATHSCHEM!',                                              
//             PATHOPTS=ORDONLY,                                                
//             RECFM=VB,LRECL=32756,BLKSIZE=32760                               
//SYSTSPRT DD  SYSOUT=*                                                         
//SYSPRINT DD  SYSOUT=*                                                         
//SYSUDUMP DD  SYSOUT=*                                                         
//*********************************************************************         
//* Create Db2 REST packages for templates                                      
//*********************************************************************         
//SYSTSIN  DD  *                                                                
  DSN SYSTEM(!DSN!)                                                             
  BIND SERVICE(DB2ICP) -                                                        
    NAME("GETALLOBJECTSBYDBNAME") -                                             
    SQLDDNAME(SQLDBNAM) -                                                       
    DESCRIPTION('ICP z/OS Broker - Get all objects by database name') -         
    OWNER(!AUTHID!) -                                                           
    ISOLATION(UR)                                                               
                                                                                
  BIND SERVICE(DB2ICP) -                                                        
    NAME("GETALLOBJECTSBYSCHEMANAME") -                                         
    SQLDDNAME(SQLSCHEM) -                                                       
    DESCRIPTION('ICP z/OS Broker - Get all objects by schema name') -           
    OWNER(!AUTHID!) -                                                           
    ISOLATION(UR)                                                               
