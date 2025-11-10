extends Node

var Materials: Dictionary = {}
func _check_in_material (mat_name: String, mat: Material)    -> void:        Materials[mat_name] = mat
func _check_material    (mat_name: String)                   -> bool: return Materials.keys().has(mat_name) 
func _check_out_material(mat_name: String)               -> Material: return Materials[mat_name] if _check_material(mat_name) else null
