#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#-- Author:		JBallard (JEB)											  										:
#-- Date:		2017.12.12											      										:
#-- Script:		SYS-BACKUP.SVN.ps1																			    :
#-- Purpose:	A script to backup the VisualSVN Repos Servers Repository.      								:
#-- Version:	1.0		  																						:
#-- ************************************************************************************************************:
#-- ************************************************************************************************************:
#--
#-- ****************************************************:
#-- DEFINE PARAMETERS & CONFIGURATION PATHS				:
#-- ****************************************************:
ADD-TYPE -ASSEMBLYNAME System.Speech
#--
$speak		= NEW-OBJECT System.Speech.Synthesis.SpeechSynthesizer
$ttlcnt		= NEW-OBJECT System.Speech.Synthesis.SpeechSynthesizer
$error		= NEW-OBJECT System.Speech.Synthesis.SpeechSynthesizer
$complete	= NEW-OBJECT System.Speech.Synthesis.SpeechSynthesizer
#--
$speak.Speak('PLEASE WAIT WHILE JB VERIFIES BACKUP PARAMS:')
#--
#-- ****************************************************:
#-- CONFIGURATION - SOURCE & DESTINATION PATHS			:
#-- ****************************************************:
$Source 	 = '\\JBALLARD-7470\C$\0_SVN\'
$Destination = '\\JBALLARD-7470\F$\0_REPOSITORY\02_EXPLORER_PIPELINE\JBALLARD-7470\0_SVN\'
#--
#-- ****************************************************:
#-- COUNT THE # OF DIRECTORIES							:
#-- ****************************************************:
$count = 0
GET-CHILDITEM $Destination
	ls ${Source}
		SELECT Name
			FOREACH-OBJECT {$count++}
				COPY-ITEM -PATH $Source -DESTINATION $Destination -FORCE -RECURSE

#-- ****************************************************:
#-- CONDITIONAL CHECK & SYSTEM SPEECH					:
#-- ****************************************************:			
$ttlcnt.Speak($count)
If ($? -ne $True)
{	
	$error.Speak('FAILED TO PROCESS SVN REPO BACKUP:')
}
else
{
	$complete.Speak('SUCCESSFULLY PROCESS SVN REPO BACKUP:')
}
#--
#-- ****************************************************:
#-- END OF POWERSHELL SCRIPT			                :
#-- ****************************************************: