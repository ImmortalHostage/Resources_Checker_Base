#include amxmodx

#define ADM_FLAG	ADMIN_LEVEL_G	// флаг админа для показа оповещений rc_say

new String[192], Time[16], File[64];

public plugin_init()
{
	register_plugin("ReChecker Logging", "freesrv", "phe");

	register_srvcmd("rc_say", "cmd_rcSay");
	register_srvcmd("rc_log", "cmd_rcLog");
	register_srvcmd("ms_log", "cmd_msLog");
	register_srvcmd("nf_log", "cmd_nfLog");
	register_srvcmd("ch_log", "cmd_chLog");
}

public cmd_rcSay()
{	
	read_args(String, charsmax(String));
	format(String, charsmax(String), "#SERVER : %s", String);
	
	#if AMXX_VERSION_NUM < 183
	new pl[32], pnum; get_players(pl, pnum, "ch");
	for(new i = 1; i <= pnum; i++)
	#else
	for(new i = 1; i <= MaxClients; i++)
	#endif
	{
		if(!is_user_connected(i))			continue;
		if(~get_user_flags(i) & ADM_FLAG)	continue;
		
		message_begin(MSG_ONE, get_user_msgid("SayText"), {0, 0, 0}, i);
		write_byte(i); write_string(String); message_end();
	}
}

public cmd_rcLog()
{
	read_args(String, charsmax(String)); get_time("%Y%m%d", Time, charsmax(Time));
	formatex(File, charsmax(File), "addons/amxmodx/logs/RC/rc_%s.log", Time);
	log_to_file(File, "%s", String);
}

public cmd_msLog()
{
	read_args(String, charsmax(String)); get_time("%Y%m%d", Time, charsmax(Time));
	formatex(File, charsmax(File), "addons/amxmodx/logs/RC/missing_%s.log", Time);
	log_to_file(File, "%s", String);
}

public cmd_nfLog()
{
	read_args(String, charsmax(String)); get_time("%Y%m%d", Time, charsmax(Time));
	formatex(File, charsmax(File), "addons/amxmodx/logs/RC/new_%s.log", Time);
	log_to_file(File, "%s", String);
}

public cmd_chLog()
{
	read_args(String, charsmax(String)); get_time("%Y%m%d", Time, charsmax(Time));
	formatex(File, charsmax(File), "addons/amxmodx/logs/RC/cheats_%s.log", Time);
	log_to_file(File, "%s", String);
}