extends Node
var LogFile

var FILE_FLUSHING_ENABLED  : bool = true
var FILE_LOGGING_ENABLED   : bool = true
var STDOUT_LOGGING_ENABLED : bool = true
var TOAST_LOGGING_ENABLED  : bool = true

var MessageBoard: CenterContainer

enum Flags {MSG, MSG_FILE, MSG_STDOUT, WARN, WARN_FILE, WARN_STDOUT, ERR, ERR_FILE, ERR_STDOUT, TOAST}

func _ready() -> void: 
	var LogsDirPath: String = "user://TTCTCG_logs/"+ get_date(true)
	var LogFilePath: String = LogsDirPath + "/" + get_time(true) + ".log"
	DirAccess.make_dir_recursive_absolute(LogsDirPath)
	LogFile = FileAccess.open(LogFilePath , FileAccess.WRITE)
	log_msg("Session Began:   " +
			"FILE_FLUSHING_ENABLED - "  + str(FILE_FLUSHING_ENABLED).to_upper()  + "   " +
			"FILE_LOGGING_ENABLED - "   + str(FILE_LOGGING_ENABLED).to_upper()   + "   " +
			"STDOUT_LOGGING_ENABLED - " + str(STDOUT_LOGGING_ENABLED).to_upper() + "   " +
			"TOAST_LOGGING_ENABLED - "  + str(TOAST_LOGGING_ENABLED).to_upper())
	
	MessageBoard = CenterContainer.new()
	MessageBoard.set_name("MessageBoard")
	MessageBoard.set_z_index(10)
	MessageBoard.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	MessageBoard.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	add_child(MessageBoard)
	
func _enact_censorship() -> void: if MessageBoard.get_child_count() > 0: MessageBoard.get_child(0).queue_free()

func post_msg_board_message(msg: String, length: float= -1) -> void: 
	while MessageBoard.get_child_count() > 0:
		var node = MessageBoard.get_child(0)
		MessageBoard.remove_child(node)
		node.queue_free()
	
	var label := Label.new()
	label.text = msg
	MessageBoard.add_child(label)
	
	if length >= 0:
		await get_tree().create_timer(length).timeout
		if label: label.queue_free()

func post_msg_board_node(node: Control, length: float = -1) -> void:
	while MessageBoard.get_child_count() > 0:
		var oldnode = MessageBoard.get_child(0)
		MessageBoard.remove_child(oldnode)
		oldnode.queue_free()
	
	MessageBoard.set_mouse_filter(Control.MOUSE_FILTER_STOP)
	MessageBoard.add_child(node)
	MessageBoard.set_theme(preload("res://1_ASSETS/UI/GeneralUITheme.tres"))
	node.tree_exiting.connect(func(): MessageBoard.set_mouse_filter(Control.MOUSE_FILTER_IGNORE))
	
	if length >= 0:
		await get_tree().create_timer(length).timeout
		node.queue_free()

func log_msg(msg: String, flags: Flags = Flags.MSG):
	var logmsg: String = ("ERROR " if flags == Flags.ERR  or flags == Flags.ERR_FILE  or flags == Flags.ERR_STDOUT  else \
						"WARNING " if flags == Flags.WARN or flags == Flags.WARN_FILE or flags == Flags.WARN_STDOUT else "") + \
						get_date() + " " + get_time() + ": " + msg
	
	if (flags == Flags.MSG  or flags == Flags.MSG_FILE or \
		flags == Flags.ERR  or flags == Flags.ERR_FILE or \
		flags == Flags.WARN or flags == Flags.WARN_FILE) and FILE_LOGGING_ENABLED:
		LogFile.store_line(logmsg)
		if FILE_FLUSHING_ENABLED: 
			LogFile.flush()
	
	if (flags == Flags.ERR or flags == Flags.ERR_STDOUT) and \
		STDOUT_LOGGING_ENABLED:
		printerr(logmsg)
	elif   (flags == Flags.MSG  or flags == Flags.MSG_STDOUT or \
			flags == Flags.WARN or flags == Flags.WARN_STDOUT) and \
			STDOUT_LOGGING_ENABLED:
		print(logmsg)
	
	if flags == Flags.TOAST and TOAST_LOGGING_ENABLED:
		if Engine.has_singleton("ToastPlugin"):
			var toast_plugin = Engine.get_singleton("ToastPlugin")
			toast_plugin.show_toast(msg)
			log_msg("LumberJack.gd - log_msg(): toasted \"" + msg + "\". Toast plugin not installed.", LOGGER.Flags.WARN)
		else:
			post_msg_board_message("cant toast, no plugin", 1.0)
			log_msg("LumberJack.gd - log_msg(): cannot toast \"" + msg + "\". Toast plugin not installed.", LOGGER.Flags.ERR)


func get_date(file_friendly : bool = false) -> String: return Time.get_date_string_from_system().replace("-", "_") if file_friendly else Time.get_date_string_from_system().replace("-", "/")
func get_time(file_friendly : bool = false) -> String: return Time.get_time_string_from_system().replace(":", "_") if file_friendly else Time.get_time_string_from_system()
