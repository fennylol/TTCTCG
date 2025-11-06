extends HBoxContainer
class_name PopUp

enum MARGIN_DIRECTIONS {TOP, LEFT, BOTTOM, RIGHT}
const DEFAULT_MARGINS: Array[int] = [16, 16, 16, 16]
signal finished (return_code: int)

func _init(margins: Array[int] = DEFAULT_MARGINS) -> void: 
	assert(margins.size() == 4)
	self.tree_exiting.connect(func(): finished.emit(0))
	self.finished.connect(func(_rc: int): if not is_queued_for_deletion(): queue_free())
