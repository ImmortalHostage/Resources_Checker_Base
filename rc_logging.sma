#include amxmisc

public plugin_init()
{
	register_plugin("ReChecker Logging", "1.0", "custom")

	register_srvcmd("rc_log", "cmd_rcLog")
}

public cmd_rcLog(id)
{
	new rcTime[16]
	new rcFile[64]
	new rcString[192]
	
	read_args(rcString,sizeof(rcString))
	get_time("%Y%m%d", rcTime, sizeof(rcTime))
	format(rcFile, sizeof(rcFile), "addons/rechecker/logs/rc_%s.log", rcTime)
	log_to_file(rcFile, "%s", rcString)
	
	return PLUGIN_HANDLED
}
