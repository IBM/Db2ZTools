# Update the sample Db2 software service template for provisioning stand-alone Db2 subsystems for APAR PH21341

 The PTF for APAR PH21341 adds a new Db2 subsystem parameter in DSN6SPRM called MFA_AUTHCACHE_UNUSED_TIME that specifies the time, in seconds, cached MFA credentials can remain unused before new credentials are required. A cached entry is unused if the client has not attempted a replay of the credentials. When the credentials are replayed, the unused time is reset.

 Valid settings are: 0, 120 - 7200.  The default is 0 seconds. If the Db2 subsystem parameter DSN6SPRM.AUTHEXIT_CACHEREFRESH is set to NONE, MFA_AUTHCACHE_UNUSED_TIME must also be 0.

 You must update the following zFS files that you have extracted from the Db2ProvisionSystemNonDS.pax file (including any extracted zFS files that you have customized) as indicated below.


## Job `dsntijuz`

(a) Locate these two lines

    #formatLine("               MAXTEMPS_RID=${MXTMPRID},",
                71,15,false,"X")

(b) Add the following two lines directly after the above lines:

    #formatLine("               MFA_AUTHCACHE_UNUSED_TIME=${MFAT},",
                71,15,false,"X")


## z/OSMF variable input file `dsntivin`

(a) Locate these two lines:

    ## -- PANEL DSNTIPP1 (PROTECTION) --             
    ## "SECADM1T" on panel DSNTIPP1: SEC ADMIN 1 TYPE

(b) Add the following 3 lines directly -before- the above lines:

    ## "MFAT" on panel DSNTIPP: MFA AUTH UNUSED TIME
    ## The MFA_AUTHCACHE_UNUSED_TIME subsystem parameter specifies the time, in seconds, cached MFA credentials can remain unused before new credentials are required. A cached entry is unused if the client has not attempted a replay of the credentials. Once, the credentials have been replayed, the unused time will be reset. Set this field to 0 if the value of the AUTHEXIT_CACHEREFRESH parameter is NONE.
    MFAT=n

    where 'n' is
      - 0, if you are updating the original dsntivin file extracted from the Db2ProvisionSystemNonDS.pax file.
      - Desired setting for MFA_AUTHCACHE_UNUSED_TIME (0, 120 - 7200), if you are updating your customized dsntivin file.

    Note: If you have set AECR=NONE (i.e., AUTHEXIT_CACHEREFRESH is set to NONE), you must set MFAT to zero.


## z/OSMF workflow definition file `dsntiwin.xml`:

(a) Locate this line:

    <variable name="MGEXTSZ" scope="instance">

(b) Add the following lines directly -before- the above line:

    <variable name="MFAT" scope="instance">
    <label>MFAT</label>
    <abstract>MFA AUTH UNUSED TIME</abstract>
    <description>
    The MFA_AUTHCACHE_UNUSED_TIME subsystem parameter specifies the time, in seconds, cached MFA credentials can remain unused before new credentials are required. A cached entry is unused if the client has not attempted a replay of the credentials. Once, the credentials have been replayed, the unused time will be reset. Set this field to 0 if the value of the AUTHEXIT_CACHEREFRESH parameter is NONE.
    </description>
    <category>ZPARMS</category>
    <string>
    <maxLength>40</maxLength>
    </string>
    </variable>

(c) Locate this line:

    <variableValue name="MGEXTSZ" scope="instance" required="false" noPromptIfSet="true"></variableValue>

(d) Add the following line directly -before- the above line:

    <variableValue name="MFAT" scope="instance" required="false" noPromptIfSet="true"></variableValue>
