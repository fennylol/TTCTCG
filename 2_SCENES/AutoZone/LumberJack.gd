extends Node
var LogFile

enum Flags {MSG, MSG_FILE, MSG_STDOUT, WARN, WARN_FILE, WARN_STDOUT, ERR, ERR_FILE, ERR_STDOUT}

func _ready() -> void: 
	var LogsDirPath: String = "user://TTCTCG_logs/"+ get_date(true)
	var LogFilePath: String = LogsDirPath + "/" + get_time(true) + ".log"
	DirAccess.make_dir_recursive_absolute(LogsDirPath)
	LogFile = FileAccess.open(LogFilePath , FileAccess.WRITE)
	var msg: String = "Session Began"
	log_msg(msg, Flags.MSG)

func log_msg(msg: String, flags: Flags = Flags.MSG):
	var logmsg: String = ("ERROR " if flags == Flags.ERR  or flags == Flags.ERR_FILE  or flags == Flags.ERR_STDOUT  else \
						"WARNING " if flags == Flags.WARN or flags == Flags.WARN_FILE or flags == Flags.WARN_STDOUT else "") + \
						get_date() + " " + get_time() + ": " + msg
	
	if  flags == Flags.MSG  or flags == Flags.MSG_FILE or \
		flags == Flags.ERR  or flags == Flags.ERR_FILE or \
		flags == Flags.WARN or flags == Flags.WARN_FILE:
		LogFile.store_line(logmsg)
		LogFile.flush()
	
	if flags == Flags.ERR or flags == Flags.ERR_STDOUT:
		printerr(logmsg)
	elif flags == Flags.MSG  or flags == Flags.MSG_STDOUT or \
		 flags == Flags.WARN or flags == Flags.WARN_STDOUT:
		print(logmsg)

func get_date(file_friendly : bool = false) -> String: return Time.get_date_string_from_system().replace("-", "_") if file_friendly else Time.get_date_string_from_system().replace("-", "/")
func get_time(file_friendly : bool = false) -> String: return Time.get_time_string_from_system().replace(":", "_") if file_friendly else Time.get_time_string_from_system()
