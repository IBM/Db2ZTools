//*********************************************************************         
//*                                                                             
//* Licensed Materials - Property of IBM                                        
//* 5650-DB2                                                                    
//* (C) COPYRIGHT 2019 IBM Corp.  All Rights Reserved.                          
//*                                                                             
//* FUNCTION = GRANT EXECUTE PRIVILEGE ON DB2 NATIVE REST SERVICE               
//*            PACKAGE FOR ICP Z/OS CLOUD BROKER.                               
//*                                                                             
//* NOTES =                                                                     
//*    PRIOR TO RUNNING THIS JOB, customize it for your system:                 
//*    (1) Add a valid job card.                                                
//*    (2) Change all occurrences of the following strings:                     
//*        (A) Change the subsystem name '!DSN!' to the SSID of your            
//*            DB2.                                                             
//*        (B) Change 'DSN!!0' to the prefix of the target library              
//*            for DB2.                                                         
//*        (C) Change 'DSNTIA!!' to the plan name for DSNTIAD on your           
//*            DB2.                                                             
//*        (D) Change '!RACFGRP!' to the RACF group with the                    
//*            privilege to execute the Db2 REST package for ICP.               
//*                                                                             
//*********************************************************************         
//JOBLIB  DD  DISP=SHR,                                                         
//            DSN=DSN!!0.SDSNLOAD                                               
//*********************************************************************         
//* Grant execute privilege on Db2 REST packages                                
//*********************************************************************         
//STEP2  EXEC PGM=IKJEFT01,DYNAMNBR=20,COND=(4,LT)                              
//SYSTSPRT DD  SYSOUT=*                                                         
//SYSPRINT DD  SYSOUT=*                                                         
//SYSUDUMP DD  SYSOUT=*                                                         
//SYSTSIN  DD  *                                                                
  DSN SYSTEM(!DSN!)                                                             
  RUN PROGRAM(DSNTIAD)  PLAN(DSNTIA!!) -                                        
       LIBRARY('DSN!!0.RUNLIB.LOAD')                                            
  END                                                                           
//SYSIN    DD  *                                                                
GRANT EXECUTE                                                                   
  ON PACKAGE DB2ICP.GETALLOBJECTSBYDBNAME                                       
  TO !RACFGRP!;                                                                 
                                                                                
GRANT EXECUTE                                                                   
  ON PACKAGE DB2ICP.GETALLOBJECTSBYSCHEMANAME                                   
  TO !RACFGRP!;                                                                 
