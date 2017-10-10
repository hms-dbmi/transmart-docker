/**
* This is the config file used by the RModules plugin
* @author SMunikuntla
*
*/
RModules
{
	//If not pulling R Scripts from Github, this needs to be used to point to the local file system.
    pluginScriptDirectory = "/Users/mmcduffie/src/tranSMART/Rmodules1_0/web-app/Rscripts/"

	defaultStatusList = ["Started",
			"Validating Cohort Information",
			"Triggering Data-Export Job",
			"Gathering Data",
			"Running Conversions",
			"Running Analysis",
			"Rendering Output"]

	//Configuration for plugins.
	tempFolderDirectory = "/mnt/tmp/jobs/"

}
