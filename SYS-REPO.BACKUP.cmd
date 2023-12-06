@ECHO Off
:: *************************************************************************************************************:
:: ****************************************** SUBVERSION BACKUP SCRIPT *****************************************:
:: *************************************************************************************************************:
:: Author:	JBallard(JEB)																						:
:: Date:	2016.9.02																							:
:: Script:	SYSTEM-SVN.BACKUP.cmd																				:
:: Effort:	To Populate Backups of the SVN Repository directory													:
:: Ver:		1.0																									:
:: *************************************************************************************************************:
:: ********************************************** MODIFICATION(s) **********************************************:
:: *************************************************************************************************************:
:: Mod By:	JBallard(JEB)																						:
:: Date:	2016.9.02																							:
:: Effort:	To Implement a SVN Repository Dump Directory														:
:: Ver:		1.1																									:
:: *************************************************************************************************************:
:: Mod By:	JBallard(JEB)																						:
:: Date:	2016.9.12																							:
:: Effort:	To Implement a SVN Repository Dump Directory														:
:: Ver:		1.2																									:
:: *************************************************************************************************************:
:: Mod By:	JBallard(JEB)																						:
:: Date:	2016.9.14																							:
:: Effort:	To Add a Date & Time stamp to the Backups															:
:: Ver:		1.3																									:
:: *************************************************************************************************************:
:: *************************************************************************************************************:
::
:: *************************************************:
:: DEFINE PARAMETERS & CONFIGURATION PATHS			:
:: *************************************************:
:: BACKUP DIRECTORY:
SET SVNBackUpPath="C:\0_SVN.BACUP.Dev\0_SVNRepo.Bck"
:: 
:: LOCAL WORKING COPY:
SET SVNStagPath="C:\0_SVN.BACUP.Dev\0_SVNRepo.Tmp"
:: 
:: SVN REPOSITORY DIRECTORY:
SET SVNRepoPath="C:\0_REPOS\0_SVN_REPO"
:: 
:: REPOSITORY NAME:
SET SVNRepoName=0_SVN_REPO
:: 
:: ADD TIME/DATE STAMP:
SET TS=%date:~10,4%_%date:~4,2%_%date:~7,2%__%time:~0,2%_%time:~3,2%_%time:~6,2%__%time:~9,2%
:: 
:: BUILDING PATHS FOR BACKUP ROUTINE:
SET SVNBackUpPath=%SVNBackUpPath%\%TS%
SET SVNBackUpPath_HotCopy=%SVNBackUpPath%\Hotcopy\
SET SVNStagingPath_WorkCopy="%SVNBackUpPath%\Working Copy\"
SET SVNBackUpPath_Dump=%SVNBackUpPath%\Dump\
SET STEPS=4
:: 
:: PUPULATE DIRECTORY STRUCTURES:
ECHO [STEP 1 OF %steps%] --- POPULATING BACKUP DIRECTORY:
MKDIR %SVNBackUpPath%
MKDIR %SVNBackUpPath_HotCopy%
MKDIR %SVNStagingPath_WorkCopy%
MKDIR %SVNBackUpPath_Dump%
ECHO [STEP 1 OF %STEPS%] --- BACKUP DIRECTORY CREATED:
:: 
ECHO [STEP 2 OF %STEPS%] --- EXECUTING HOTCOPY:
svnadmin hotcopy %SVNRepoPath% %SVNBackUpPath_HotCopy% --clean-logs
ECHO [STEP 2 of %STEPS%] --- HOTCOPY COMPLETED:
:: 
ECHO [STEP 3 OF %STEPS%] --- POPULATING DUMP DIRECTORY:
svnadmin dump %SVNRepoPath% | "%ProgramFiles%\7-Zip\7z.exe" a %SVNBackUpPath_Dump%\%SVNRepoName%.7z -si%SVNRepoName%.svn
ECHO [STEP 3 OF %STEPS%] --- DUMP DIRECTORY CREATED:
:: 
ECHO [STEP 4 OF %STEPS%] --- CREATING WORKING DIRECTORY:
xcopy.exe /s /e /y /i %SVNStagPath% %SVNStagingPath_WorkCopy%
ECHO [STEP 4 OF %STEPS%] --- WORKING DIRECTORY BACKED UP:
:: 
PAUSE
::
:: *************************************************:
:: END OF SCRIPT									:
:: *************************************************: